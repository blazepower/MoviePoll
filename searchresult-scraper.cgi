#! usr/bin/awk -f
BEGIN {
  ofile = "/tmp/sey13.list.json"
  # ofile = "list.json"
  print "[" > ofile
  # if the user searches for "black swan" (no quotes)
  # user input will be of the form "black+swan" (no quotes)
  userinput = ENVIRON["QUERY_STRING"]
  # userinput = "black+swan";
  sub(/+/,"%20",userinput);
  link = "metacritic.com/search/all/" userinput "/results"
  system("wget -O /tmp/sey13.link1.txt " link);
  line = 13
  special = 0
  FS = ">";
  while (getline < "/tmp/sey13.link1.txt" > 0) {
    if($1 ~ /<h3 class="product_title basic_stat/) {
      line = 0;
    }
    line = line + 1
    if(line == 2) {
      link = $1
      print "\t{" > ofile
      gsub(/^[ \t]+/,"",link)
      sub(/<a href="/,"",link)
      sub(/"/,"",link)
      if(link != "") {
        link = "metacritic.com"link
        print "\t\t\"link\": \""link"\"," > ofile
      }
    }
    if(line == 3) {
      if(NF == 3) {
        title = $3
      }
      else { title = $1 }
      gsub(/^[ \t]+/,"",title)
      if(title != "") {
        print "\t\t\"title\": \""title"\"," > ofile
      }
    }
    if(line == 7) {
      if($1 ~ /<span class="platform"/) {
        line = line - 1
      }
    }
    if(line == 8) {
      datetyperating = $1
      if($1 ~ /<span class="label"/) {
        datetyperating = "empty"
      }
      gsub(/^[ \t]+/,"",datetyperating)
      gsub(/<\/p/,"",datetyperating)
      gsub(/[ \t]+$/,"",datetyperating)
      if(datetyperating != "empty" && datetyperating != "") {
        print "\t\t\"date_type_rating\": \""datetyperating"\"," > ofile
      }
    }
    if(line == 11) {
      description = $2
      gsub(/^[ \t]+/,"",description)
      gsub(/<\/p/,"",description)
      gsub(/"/,"",description)
      if(description != "") {
        print "\t\t\"description\": \""description"\"" > ofile
        print "\t}," > ofile
      } else {
        special = 1
      }
    }
    if(line == 12 && special == 1) {
      description = $2
      gsub(/^[ \t]+/,"",description)
      gsub(/<\/p/,"",description)
      gsub(/"/,"",description)
      if(description != "") {
        print "\t\t\"description\": \""description"\"" > ofile
      }
      print "\t}," > ofile
      special = 0
    }
  }

  print "]" > ofile
}
