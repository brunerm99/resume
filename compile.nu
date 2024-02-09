def main [
  --fname (-f): string = "MarshallBruner" # Output filename
] {
  let outdir = $"(git rev-parse --show-toplevel)/outputs/(git rev-parse --abbrev-ref HEAD)"
  mkdir $outdir
  let output = (pdflatex $"-jobname=($fname)" $"-output-directory=($outdir)" resume.tex | complete)
  if $output.exit_code > 0 {
    print $output.stdout
  } else {
    print $"File successfully saved to ($outdir | path join $fname).pdf"
  }
}
