export def main [
  --fname (-f): string = "MarshallBruner" # Output filename
] {
  let outdir = (get-output-path)
  mkdir $outdir
  let output = (pdflatex $"-jobname=($fname)" $"-output-directory=($outdir)" resume.tex | complete)
  if $output.exit_code > 0 {
    print $output.stdout
  } else {
    print $"File successfully saved to ($outdir | path join $fname).pdf"
  }
}

export def get-output-path [] -> path {
  $"(git rev-parse --show-toplevel)/outputs/(git rev-parse --abbrev-ref HEAD)"
}

export def open-viewer [] -> bool {
  if (ps | where name == (which pueued | get path.0) | is-empty) { pueued -d }
  let output_path = (get-output-path)
  if ($output_path | path exists) { 
    pueue add okular $output_path 
    true
  } else {
    print $"Failed to open ($output_path), try compiling first"
    false
  }
}
