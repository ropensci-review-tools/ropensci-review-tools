pkgs <- readLines ("packages.md")

update_index_rst <- function (pkgs) {

    f <- fs::dir_ls ("docs/", type = "file", regexp = "index\\.rst$") |>
        fs::path_abs ()
    index <- readLines (f)
    toc <- grep ("toctree\\:\\:", index)
    # package index is second toctree:
    blank <- which (!nzchar (index))
    blank <- blank [which (blank > toc [2] & blank < toc [3])]
    pkgs_start <- blank [1] + 1L
    pkgs_end <- blank [2] - 1L
    pkgs_index <- seq (pkgs_start, pkgs_end)

    wsp <- paste (rep (" ", 3L), collapse = "")
    pkg_mds <- paste0 (wsp, pkgs, "/", pkgs, ".md")

    index <- c (
        index [seq_len (pkgs_start - 1L)],
        pkg_mds,
        index [seq (pkgs_end + 1, length (index))]
    )
    writeLines (index, f)
}
update_index_rst (pkgs)

path <- normalizePath ("..")

one_docs2md <- function (p, path) {

    flist <- list.files (file.path (path, p, "man"),
                         full.names = TRUE,
                         pattern = "\\.Rd$")

    path_loc <- file.path (path, "ropensci-review-tools", "docs", p)
    path_loc <- normalizePath (path_loc, mustWork = FALSE)
    if (!dir.exists (path_loc)) {
        dir.create (path_loc, recursive = TRUE)
    }

    path_loc_fns <- file.path (path_loc, "functions")
    if (!dir.exists (path_loc_fns)) {
        dir.create (path_loc_fns, recursive = TRUE)
    }

    for (f in flist) {

        fshort <- utils::tail (strsplit (f, .Platform$file.sep) [[1]], 1L)
        fout <- file.path (path_loc_fns, gsub ("\\.Rd$", ".md", fshort))
        md <- Rd2md::read_rdfile (f) |> Rd2md::as_markdown ()
        writeLines (md, con = fout)
    }
}

#' Render vignettes for one package to markdown and move to docs
#'
#' All vignettes are presumed to have `.Rmd` source files. If these do not also
#' exist as `.md`, then they are first rendered before copying across.
#' @noRd
one_vignettes <- function (p, path) {

    flist <- list.files (file.path (path, p, "vignettes"),
                         full.names = TRUE,
                         recursive = TRUE,
                         pattern = "\\.Rmd")

    flist_md <- vapply (flist, function (i) {
                            i_rmd <- basename (i)
                            i_md <- gsub ("\\.Rmd$", ".md", i_rmd)
                            return (gsub (i_rmd, i_md, i))
                         }, character (1),
                         USE.NAMES = FALSE)

    if (length (flist_md) == 0L)
        return (NULL)

    for (i in seq_along (flist_md)) {
        
        if (!file.exists (flist_md [i])) {

            # https://github.com/wch/webshot/issues/115
            withr::with_envvar (
                c ("OPENSSL_CONF" = "/dev/null"), {
                    rmarkdown::render (flist [i],
                        output_format = rmarkdown::md_document (variant = "gfm"))
                    #output_file = flist_md [i])
            })
            message ("[", flist [i], "] has been rendered to [",
                     flist_md [i], "]")
        }

        x <- brio::read_lines (flist_md [i])
        if (!any (grepl ("^\\#\\s", x))) {
            x_rmd <- brio::read_lines (flist [i])
            titl <- grep ("^title\\:\\s", x_rmd) [1]
            titl <- gsub ("^title\\:\\s", "", x_rmd [titl])
            titl <- gsub ("\\\"", "", titl)
            x <- c (paste0 ("# ", titl),
                    "",
                    x)
            brio::write_lines (x, flist_md [i])
        }
    }

    docs_path <- file.path (path, "ropensci-review-tools", "docs")
    v_path <- file.path (docs_path, p, "vignettes")
    if (!dir.exists (v_path)) {
        dir.create (v_path, recursive = TRUE)
    }

    for (f in flist_md) {
        file.copy (f, v_path, overwrite = TRUE)
    }
}

one_readme <- function (p, path) {

    orig <- file.path (path, p, "README.md")
    if (!file.exists (orig)) {
        stop ("file [", orig, "] not found")
    }

    docs_path <- file.path (path, "ropensci-review-tools", "docs")
    pkg_path <- file.path (path, p)
    if (!dir.exists (pkg_path)) {
        stop ("directory [", pkg_path, "] not found")
    }

    dest <- file.path (docs_path, p, paste0 (p, ".md"))
    chk <- file.copy (orig, dest, overwrite = TRUE)

    x <- c (brio::read_lines (dest),
            "",
            "## Functions",
            "",
            "```{toctree}",
            ":maxdepth: 1",
            "")

    fns_path <- file.path (docs_path, p, "functions")
    for (f in list.files (fns_path)) {

        x <- c (x,
                paste0 ("functions/", f))
    }
    x <- c (x, "```")

    v_dir <- file.path (docs_path, p, "vignettes")
    if (dir.exists (v_dir)) {

        x <- c (x,
                "",
                "## Vignettes",
                "",
                "```{toctree}",
                ":maxdepth: 1",
                "")

        v_files <- list.files (v_dir, pattern = "\\.md$")
        for (f in v_files) {
            x <- c (x, paste0 ("vignettes/", f))
        }
        x <- c (x, "```")
    }

    brio::write_lines (x, dest)
}

# Hex (or other) images included in readme titles are also rendered in
# 'readthedocs' contents table on left panel. This function moves any such
# images to a separate line so they only appear in the readme docs themselves.
move_hex <- function (p, path) {

    docs_path <- file.path (path, "ropensci-review-tools", "docs")
    pkg_path <- file.path (docs_path, p)
    f <- file.path (pkg_path, paste0 (p, ".md"))

    x <- gsub ("^\\s+$", "", brio::read_lines (f))
    x <- x [(which (nchar (x) > 0L) [1]):length (x)]

    if (grepl ("<img src", x [1])) {

        src <- strsplit (x [1], "<img src") [[1]] [2]
        fig_src <- regmatches (src, gregexpr ("\'.*\'|\".*\"", src)) [[1]] [1]
        fig_src <- gsub ("\"|\'", "", fig_src)
        fig_src_name <- strsplit (fig_src, .Platform$file.sep) [[1]]
        fig_src_name <- utils::tail (fig_src_name, 1)

        dir_dest <- file.path (docs_path, "_static", p)
        fig_dest <- file.path (dir_dest, fig_src_name)
        if (!file.exists (fig_dest)) {
            if (!dir.exists (dir_dest))
                dir.create (dir_dest, recursive = TRUE)
            chk <- file.copy (file.path (path, p, fig_src), fig_dest)
        }

        fig_rel <- gsub (paste0 ("docs", .Platform$file.sep), "",  fig_dest)
        tmp <- gsub (fig_src, fig_rel, x [1])
        tmp <- strsplit (tmp, "<img src") [[1]]
        x <- c (tmp [1],
                "",
                paste0 ("<img src", tmp [2]),
                x [2:length (x)])

        brio::write_lines (x, f)
    }
}


for (p in pkgs) {

    one_docs2md (p, path)
    one_vignettes (p, path)
    one_readme (p, path)
    move_hex (p, path)
}

do_not_include <- normalizePath (c (
    "docs/srr/vignettes/review-tools.md"
))
do_not_include <- do_not_include [which (file.exists (do_not_include))]
file.remove (do_not_include)
