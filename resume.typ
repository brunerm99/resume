// Marshall Bruner's resume
//
// HOW TO EDIT
// - Each entry is one function call: job, project, project-single, school, skill.
// - Bullets are an array of content blocks: ( [first], [second], ).
//   Commas inside a bullet are fine. Keep the trailing comma.
// - Spacing is handled by the functions; don't sprinkle v() between entries.
// - Entry headers stick to their bullets, so they never orphan at a page bottom.
// - highlight[...] marks key phrases; switch its definition below to turn it on.
//
// Compile once:   typst compile resume.typ
// Live preview:   typst watch resume.typ   (then open resume.pdf in a viewer that reloads)

// ---------- Highlight: pick one ----------
#let highlight(body) = body                              // off (plain text)
// #let highlight(body) = strong(body)                   // bold only
// #let highlight(body) = text(fill: blue, strong(body)) // bold + blue

// ---------- Spacing knobs ----------
#let entry-gap = 3.5mm        // space after each entry (separates jobs)
#let head-to-bullets = -1mm   // pull bullets up under the entry header

// ---------- Page and text ----------
#set page(paper: "us-letter", margin: (x: 6mm, top: 10mm, bottom: 10mm))
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.5em)
#set list(indent: 0.4em, body-indent: 0.5em, tight: true, spacing: 0.55em)
#show link: it => it

// Section headings: bold, with a rule underneath
#show heading.where(level: 1): it => block(above: 5mm, below: 3mm, width: 100%)[
  #text(size: 13pt, weight: "bold")[#it.body]
  #v(-2.5mm)
  #line(length: 100%, stroke: 0.5pt)
]

// ---------- Icons (Font Awesome 6 OTF files from TeX Live, installed in ~/.local/share/fonts) ----------
#let fa(code, brands: false) = text(
  font: if brands { "Font Awesome 6 Brands" } else { "Font Awesome 6 Free Solid" },
  weight: if brands { 400 } else { 900 },
  size: 0.9em,
)[#str.from-unicode(code)]

#let contact(icon, body, url: none) = {
  let c = box[#icon #h(0.3em) #underline(body)]
  if url != none { link(url, c) } else { c }
}

// ---------- Header ----------
#let header(name, phone, email, linkedin, github, youtube, website) = align(center)[
  #text(font: "IBM Plex Mono", size: 25pt)[#name]
  #v(-1mm)
  #set text(size: 10pt)
  #contact(fa(0xf095), phone)
  #h(1em)
  #contact(fa(0xf0e0), email, url: "mailto:" + email)
  #h(1em)
  #contact(fa(0xf08c, brands: true), linkedin, url: "https://linkedin.com/in/" + linkedin)
  \
  #contact(fa(0xf09b, brands: true), github, url: "https://github.com/" + github)
  #h(1em)
  #contact(fa(0xf167, brands: true), youtube, url: "https://youtube.com/" + youtube)
  #h(1em)
  #contact(fa(0xf0ac), website, url: "https://" + website)
]

// ---------- Entry helpers ----------
#let entry-head(left-top, right-top, left-bottom: none, right-bottom: none) = block(
  sticky: true,
  width: 100%,
  grid(
    columns: (1fr, auto),
    align: (left, right),
    row-gutter: 0.6em,
    text(size: 12pt, weight: "bold")[#left-top], text(weight: "bold")[#right-top],
    ..if left-bottom != none { (emph(left-bottom), emph(right-bottom)) } else { () },
  ),
)

#let bullets(items) = {
  v(head-to-bullets)
  list(..items)
  v(entry-gap)
}

// Job: company, start, end, position, location, bullets
#let job(company, start, end, position, location, items) = {
  entry-head(company, [#start — #end], left-bottom: underline(position), right-bottom: location)
  bullets(items)
}

// Project with a date range: title, start, end, bullets, url (or none)
#let project(title, start, end, items, url: none) = {
  let t = if url != none { link(url, underline(title)) } else { underline(title) }
  entry-head(t, [#start — #end])
  bullets(items)
}

// Project with a single date: title, date, bullets, url (or none)
#let project-single(title, date, items, url: none) = {
  let t = if url != none { link(url, underline(title)) } else { underline(title) }
  entry-head(t, date)
  bullets(items)
}

// School: school, degree, gpa, start, end, location, note (thesis etc., optional)
#let school(name, degree, gpa, start, end, location, note: none) = {
  entry-head(name, [#start — #end], left-bottom: [#degree — *GPA: #gpa*], right-bottom: location)
  if note != none {
    v(-1mm)
    emph(note)
  }
  v(entry-gap)
}

// Skill line: group, items
#let skill(group, items) = par(justify: false)[*#group:* #items]

// =====================================================================

#header(
  "Marshall Bruner",
  "+1 719-553-9497",
  "brunerm99@gmail.com",
  "marshall-bruner",
  "brunerm99",
  "@MarshallBrunerRF",
  "marshallbruner.com",
)

#v(1mm)
#align(center)[
  _RF hardware, signal processing, and weather radar deployment | Teaching 50k+ engineers on YouTube_
]

= EXPERIENCE

#job("Rainmaker Technology Corporation", "Aug 2025", "Oct 2026", "Head Radar Systems Engineer", "Boulder, CO", (
  [#highlight[Led radar engineering for a cloud-seeding company] across S-, X-, and K-band systems],
  [#highlight[Designed a 24 GHz FMCW cloud-profiling radar] from RF architecture through PCB layout, fab, and bring-up],
  [Built its FPGA gateware, embedded control server, and signal processing pipeline],
  [#highlight[Operated and deployed a 25 kW X-band dual-pol weather radar], including a mountain-top installation],
  [Architected a solid-state pulse-compression X-band radar and built radar siting and performance-modeling tools],
))

#job("CSU-CHILL National Radar Facility", "Jan 2025", "Present", "Radar Systems Engineer (part-time)", "Greeley, CO", (
  [#highlight[Built the facility's real-time multi-radar web display], serving 8 radars and 14 polarimetric products],
  [#highlight[Wrote the antenna positioner controller for a solid-state C-band radar], from pedestal protocol to operator UI],
  [Maintained an X-band dual-pol signal processing chain and authored its operational scan patterns],
  [Supported relocation and re-commissioning of a dual-pol S-band weather radar at Kwajalein Atoll],
))

#job([BAE Systems (#highlight[DoD Clearance])], "Jul 2024", "Jul 2025", "RF Engineer", "Westminster, CO", (
  [#highlight[System design, schematic capture, and layout of a 2D active phased array weather radar]],
  [Large-scale phased array systems analysis],
  [Technical consultant on weather radar proposals],
))

#job([Ball Aerospace (#highlight[DoD Clearance])], "Jun 2021", "Jul 2023", "RF Engineer", "Westminster, CO", (
  [#highlight[Designed and debugged multiple mission-critical RF boards under strict time constraints]],
  [Simulated, designed, and tested an RF front-end PCB at extreme temperatures],
  [#highlight[Schematic capture and layout of RF T/R systems], antenna range test equipment, and test coupons],
  [Built an embedded webpage to control and monitor phased array electronics],
))

#job("Colorado State University", "Jan 2021", "May 2022", "Graduate Research Assistant | Thesis focused on Radar", "Fort Collins, CO", (
  [#highlight[Designed and laid out a modular X-band FMCW drone radar]],
  [#highlight[Signal processing and visualization] for Analog Devices' FMCW Phaser board, shown by ADI at IMS 2022],
  [Presented at the IEEE International Symposium on Phased Array Systems and Technology],
))

#job("CSU-CHILL Radar Lab", "May 2020", "May 2021", "Lab Assistant", "Greeley, CO", (
  [Built a server to host and display real-time and historical radar data],
  [Characterized and measured radar equipment],
))

= PROJECTS

#project("Marshall Bruner RF — Radar / RF Education YouTube Channel", "Aug 2023", "Present", (
  [#highlight[53k subscribers and 1.4M+ views] across 17 animated videos on radar, phased arrays, and signal processing],
  [Write, animate, narrate, and edit every video; built a reusable radar animation library],
  [Ship companion interactive notebooks and a 3D weather-radar animation tool],
), url: "https://www.youtube.com/@MarshallBrunerRF")

#project-single("FMCW Radar Bootcamp — IEEE AESS RadarConf", "Mar 2023", (
  [Developed #highlight[signal processing software and a presentation] for the 2023 AESS Radar Bootcamp],
), url: "https://radar2023.ieee-radarconf.org/radar-boot-camp")

= EDUCATION

#school("Colorado State University", "M.S. Electrical Engineering", "3.9", "Jan 2021", "May 2022", "Fort Collins, CO",
  note: "Thesis - Design, Deployment, and Cost Considerations for DARMA; A Low-Cost and Lightweight FMCW Radar")

#school("Colorado State University", "B.S. Electrical Engineering", "3.47", "Aug 2017", "May 2021", "Fort Collins, CO")

= SKILLS & ABILITIES

#skill("Radar / RF", [FMCW and pulsed radar design, pulse compression, dual-pol polarimetry, phased arrays, link budgets, Doppler processing, weather radar operations])
#skill("Languages", [Python (NumPy, SciPy, Pandas, PyTorch, FastAPI, Flask), Rust, Go, C / C++, SystemVerilog, Bash, SQL, Matlab, TypeScript])
#skill("Design / Simulation Tools", [KiCad, AWR Microwave Office, HFSS, ADS, LTSpice, Cadence, QucsStudio, Vivado])
#skill("Lab / Infrastructure", [VNA, spectrum analyzer, oscilloscope, noise figure and high-power test; Git, Linux, Docker, PostgreSQL, Tailscale, LaTeX, Manim])
#skill("Communication", [Technical presentations and design reviews (PDR / CDR), customer pre- and post-sales support, educational content reaching 50k+ engineers])
