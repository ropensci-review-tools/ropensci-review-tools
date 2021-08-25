pkgs <- c ("autotest",
           "pkgcheck",
           "pkgstats",
           "roreviewapi",
           "srr")

path <- ".."

one_docs2md <- function (p, path) {

    flist <- list.files (file.path (path, p, "man"),
                         full.names = TRUE,
                         pattern = "\\.Rd$")
    path_loc <- normalizePath (file.path ("docs", p),
                               mustWork = FALSE)
    if (!dir.exists (path_loc))
        dir.create (path_loc, recursive = TRUE)

    for (f in flist) {

        fshort <- utils::tail (strsplit (f, .Platform$file.sep) [[1]], 1L)
        fout <- file.path (path_loc, gsub ("\\.Rd$", ".md", fshort))
        Rd2md::Rd2markdown (f, outfile = fout)
    }
}

one_readme <- function (p, path) {

    orig <- file.path (path, p, "README.md")
    if (!file.exists (orig))
        stop ("file [", orig, "] not found")

    dest <- file.path ("docs", paste0 (p, ".md"))
    chk <- file.copy (orig, dest)

    p <- file.path ("docs", p)
    if (!dir.exists (p))
        stop ("directory [", p, "] not found")

    x <- c (brio::read_lines (dest),
            "",
            "## Functions",
            "",
            "```eval_rst",
            ".. toctree::",
            "   :maxdepth: 1",
            "")

    for (f in list.files (p)) {

        psub <- gsub (paste0 ("docs", .Platform$file.sep), "", p)
        x <- c (x,
                paste0 ("   ", psub, "/", f))
    }
    x <- c (x, "```")

    brio::write_lines (x, dest)
}

# Hex (or other) images included in readme titles are also rendered in
# 'readthedocs' contents table on left panel. This function moves any such
# images to a separate line so they only appear in the readme docs themselves.
move_hex <- function (p, path) {

    f <- file.path ("docs", paste0 (p, ".md"))

    x <- gsub ("^\\s+$", "", brio::read_lines (f))
    x <- x [(which (nchar (x) > 0L) [1]):length (x)]

    if (grepl ("<img src", x [1])) {

        src <- strsplit (x [1], "<img src") [[1]] [2]
        fig_src <- regmatches (src, gregexpr ("\'.*\'|\".*\"", src)) [[1]] [1]
        fig_src <- gsub ("\"|\'", "", fig_src)
        fig_src_name <- strsplit (fig_src, .Platform$file.sep) [[1]]
        fig_src_name <- utils::tail (fig_src_name, 1)

        dir_dest <- file.path ("docs", "_static", p)
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
    one_readme (p, path)
    move_hex (p, path)
}
