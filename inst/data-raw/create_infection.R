InfectionByCounty <- tibble::as.tibble(utils::read.csv("InfectionByCounty.csv", sep = ";"))
save(InfectionByCounty, file = "../../data/InfectionByCounty.rda")
