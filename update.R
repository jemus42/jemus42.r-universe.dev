#! /usr/bin/env Rscript

cli::cli_h2("Updating packages.json")

cli::cli_text("Getting current packages.json")
packages <- jsonlite::read_json("packages.json", simplifyVector = TRUE)
packages <- tibble::as_tibble(packages)

if (is.null(packages[["subdir"]])) {
  packages[["subdir"]] <- NA
}

cli::cli_text("Found {nrow(packages)} packages in packages.json")

cli::cli_text("Assembling packages from tribble")
new_packages <- tibble::tribble(
                ~package,                                              ~url, ~subdir,
                 "poddr",                "https://github.com/jemus42/poddr", NA,
                 "jermd",                "https://github.com/jemus42/jermd", NA,
                "jemisc",               "https://github.com/jemus42/jemisc", NA,
                 "tRakt",                "https://github.com/jemus42/tRakt", NA,
            "discordiar",           "https://github.com/jemus42/discordiar", NA,
             "speedrunr",            "https://github.com/jemus42/speedrunr", NA,
               "radarrr",              "https://github.com/jemus42/radarrr", NA,
             "attrakttv",            "https://github.com/jemus42/attrakttv", NA,
              "tauturri",             "https://github.com/jemus42/tauturri", NA
  )

cli::cli_text("Found {nrow(new_packages)} packages in tribble")

if (!identical(packages, new_packages)) {
  cli::cli_alert_info("Writing new packages.json")
  jsonlite::write_json(new_packages, "packages.json", pretty = TRUE)
} else {
  cli::cli_alert_info("packages.json already up to date")
}
