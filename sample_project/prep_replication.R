library(knitr)
library(stringr)

extract_code_with_chunks <- function(input_file, output_file, title = "Document") {
  # Read the content of the .qmd file
  content <- readLines(input_file)
  
  # Initialize a variable to store the extracted code
  extracted_code <- character(0)
  
  # Flag to check if we are inside a code chunk
  inside_chunk <- FALSE
  
  for (line in content) {
    # Detect the start of a code chunk
    if (str_detect(line, "^```\\{")) {
      inside_chunk <- TRUE
      extracted_code <- c(extracted_code, line)
    } else if (inside_chunk && str_detect(line, "^```$")) {
      # Detect the end of a code chunk
      inside_chunk <- FALSE
      extracted_code <- c(extracted_code, line, "")
    } else if (inside_chunk) {
      # Add lines inside code chunks
      extracted_code <- c(extracted_code, line)
    }
  }
  
  # Create the YAML header
  yaml_header <- c(
    "---",
    paste0("title: \"", title, "\""),
    "format:",
    "   html:",
    "     embed-resources: true",
    "---",
    ""
  )
  
  # Combine the YAML header with the extracted code
  full_content <- c(yaml_header, extracted_code)
  
  # Write the combined content to the output file
  writeLines(full_content, output_file)
}

# Example usage

extract_code_with_chunks('my_paper.qmd', 'replication.qmd', title = "My Analysis")

rmarkdown::render("replication.qmd")
