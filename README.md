# `once`

![badge](https://github.com/gdmcdonald/once/actions/workflows/r.yml/badge.svg)

<img width="260" alt="once" src="https://user-images.githubusercontent.com/20785842/187124151-f16587c9-bc87-4deb-8c75-7943a2126f14.png">

An R package that makes it easy to execute expensive operations only once.

Wrap an expensive operation so that output is saved to disk. If the file exists, it won't run again, it will just load the saved version. 

Eg. instead of 

```{r}
file_path <- "saved_models/my_trained_models.Rds"

if (file.exists(file_path)){

  my_number <- readRDS(file = file_path)

} else {

  my_number <-
    runif(1e8) %>% # some expensive operation
    mean()
  # or ML model training such as `my_trained_models <- train_models_function(...)`
  
  saveRDS(my_number, file = file_path)
}
```

it would look like

```{r}
my_number <-
  runif(1e8) %>% # some expensive operation
  mean() %>%
  once(file_path = "saved_random_number.Rds") # only do it once, save output to this file.
```

## Install instructions

```{r}
#install.packages("devtools")
devtools::install_github("gdmcdonald/once")
library(once)
```
