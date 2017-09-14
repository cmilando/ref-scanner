#' add contents to the hash table
get_keys <- function(s) {
  s1 <- gsub("\n", " ", s)
  s2 <- gsub("\t", " ", s1)
  s3 <- gsub("[[:punct:]]", "", s2)
  s4a <- strsplit(s3, " ")[[1]]
  s4b <- strsplit(tolower(s3), " ")[[1]]
  s5 <- sort(unique(c(s4a, s4b)))
  return(s5[s5 != ''])
}


add_to_hash <- function(x, v, h) {
  val <- c()
  if(exists(x, h)) val <- get(x, h)
  assign(x, c(v, val), h)
}

getA1 <- function(w, sht) {
  names(readWorksheet(w, sheet = 'DB',startCol = 1, endCol = 1,
                      startRow = 1, endRow = 1, readStrategy = "fast"))
}

get_cat_list <- function(theObject) {
  
  cat_list <- c()

  for(i in 1:length(theObject@library)) {
    
    ref <- theObject@library[[i]]
    
    citation <- gsub('"',"'",ref@citation,fixed = T)
    citation <- gsub('&',"And",citation,fixed = T)
    citation_u <- citation
    notes <- gsub('\n',' \\\\ \\\\',ref@notes, fixed = T)
    notes_u <- notes
    #notes <- gsub("'","\'",notes, fixed = T)
    
    cat_list <- c(cat_list, paste0('\\indent '))
    
    cat_list <- c(cat_list, paste0('\\textbf{\\underline{',ref@id,'}} ',sep=''))
    cat_list <- c(cat_list, paste0('\\textit{',citation_u,'} ',sep=''))
    cat_list <- c(cat_list, paste0('\\href{',ref@link,'}{link to article} ',sep=''))
    
    cat_list <- c(cat_list, paste0('\\\\  \\\\'))
    cat_list <- c(cat_list, paste0(notes_u))
    cat_list <- c(cat_list, paste0('\\\\  \\\\'))
    
  }
  
  return(cat_list)
  
}
