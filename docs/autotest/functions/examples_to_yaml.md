# `examples_to_yaml`

examples_to_yaml


## Description

Convert examples for a specified package, optionally restricted to one or
 more specified functions, to a list of 'autotest' 'yaml' objects to use to
 automatically test package.


## Usage

```r
examples_to_yaml(
  package = NULL,
  functions = NULL,
  exclude = NULL,
  quiet = FALSE
)
```


## Arguments

Argument      |Description
------------- |----------------
`package`     |     Name of package, as either  

*  Path to local package source 

*  Name of installed package 

*  Full path to location of installed package if not on [.libPaths](#.libpaths) , or 

*  Default which presumes current directory is within package to be tested.
`functions`     |     If specified, names of functions from which examples are to be obtained.
`exclude`     |     Names of functions to exclude from 'yaml' template
`quiet`     |     If 'FALSE', provide printed output on screen.


## Seealso

Other yaml:
 [`at_yaml_template`](#atyamltemplate)


