set n [molinfo top get numreps]
set n [expr {$n + 1}]
puts "Creating representation # $n..."

mol representation NewCartoon 0.300000 10.000000 4.100000 0
mol color ColorID 1
mol selection {residue 1 to 310}
mol material Opaque
mol addrep top
mol selupdate 3 top 0
mol colupdate 3 top 0
mol scaleminmax top 3 0.000000 0.000000
mol smoothrep top 3 0
mol drawframes top 3 {now}
mol clipplane center 0 3 top {0.0 0.0 0.0}
mol clipplane color  0 3 top {0.5 0.5 0.5 }
mol clipplane normal 0 3 top {0.0 0.0 1.0}
mol clipplane status 0 3 top {0}
mol clipplane center 1 3 top {0.0 0.0 0.0}
mol clipplane color  1 3 top {0.5 0.5 0.5 }
mol clipplane normal 1 3 top {0.0 0.0 1.0}
mol clipplane status 1 3 top {0}
mol clipplane center 2 3 top {0.0 0.0 0.0}
mol clipplane color  2 3 top {0.5 0.5 0.5 }
mol clipplane normal 2 3 top {0.0 0.0 1.0}
mol clipplane status 2 3 top {0}
mol clipplane center 3 3 top {0.0 0.0 0.0}
mol clipplane color  3 3 top {0.5 0.5 0.5 }
mol clipplane normal 3 3 top {0.0 0.0 1.0}
mol clipplane status 3 3 top {0}
mol clipplane center 4 3 top {0.0 0.0 0.0}
mol clipplane color  4 3 top {0.5 0.5 0.5 }
mol clipplane normal 4 3 top {0.0 0.0 1.0}
mol clipplane status 4 3 top {0}
mol clipplane center 5 3 top {0.0 0.0 0.0}
mol clipplane color  5 3 top {0.5 0.5 0.5 }
mol clipplane normal 5 3 top {0.0 0.0 1.0}
mol clipplane status 5 3 top {0}
mol representation NewCartoon 0.300000 10.000000 4.100000 0
mol color ColorID 4
mol selection {residue 311 to 621}
mol material Opaque
mol addrep top
mol selupdate 4 top 0
mol colupdate 4 top 0
mol scaleminmax top 4 0.000000 0.000000
mol smoothrep top 4 0
mol drawframes top 4 {now}
mol clipplane center 0 4 top {0.0 0.0 0.0}
mol clipplane color  0 4 top {0.5 0.5 0.5 }
mol clipplane normal 0 4 top {0.0 0.0 1.0}
mol clipplane status 0 4 top {0}
mol clipplane center 1 4 top {0.0 0.0 0.0}
mol clipplane color  1 4 top {0.5 0.5 0.5 }
mol clipplane normal 1 4 top {0.0 0.0 1.0}
mol clipplane status 1 4 top {0}
mol clipplane center 2 4 top {0.0 0.0 0.0}
mol clipplane color  2 4 top {0.5 0.5 0.5 }
mol clipplane normal 2 4 top {0.0 0.0 1.0}
mol clipplane status 2 4 top {0}
mol clipplane center 3 4 top {0.0 0.0 0.0}
mol clipplane color  3 4 top {0.5 0.5 0.5 }
mol clipplane normal 3 4 top {0.0 0.0 1.0}
mol clipplane status 3 4 top {0}
mol clipplane center 4 4 top {0.0 0.0 0.0}
mol clipplane color  4 4 top {0.5 0.5 0.5 }
mol clipplane normal 4 4 top {0.0 0.0 1.0}
mol clipplane status 4 4 top {0}
mol clipplane center 5 4 top {0.0 0.0 0.0}
mol clipplane color  5 4 top {0.5 0.5 0.5 }
mol clipplane normal 5 4 top {0.0 0.0 1.0}
mol clipplane status 5 4 top {0}
mol representation NewCartoon 0.300000 10.000000 4.100000 0
mol color ColorID 19
mol selection {residue 622 to 932}
mol material Opaque
mol addrep top
mol selupdate 5 top 0
mol colupdate 5 top 0
mol scaleminmax top 5 0.000000 0.000000
mol smoothrep top 5 0
mol drawframes top 5 {now}
mol clipplane center 0 5 top {0.0 0.0 0.0}
mol clipplane color  0 5 top {0.5 0.5 0.5 }
mol clipplane normal 0 5 top {0.0 0.0 1.0}
mol clipplane status 0 5 top {0}
mol clipplane center 1 5 top {0.0 0.0 0.0}
mol clipplane color  1 5 top {0.5 0.5 0.5 }
mol clipplane normal 1 5 top {0.0 0.0 1.0}
mol clipplane status 1 5 top {0}
mol clipplane center 2 5 top {0.0 0.0 0.0}
mol clipplane color  2 5 top {0.5 0.5 0.5 }
mol clipplane normal 2 5 top {0.0 0.0 1.0}
mol clipplane status 2 5 top {0}
mol clipplane center 3 5 top {0.0 0.0 0.0}
mol clipplane color  3 5 top {0.5 0.5 0.5 }
mol clipplane normal 3 5 top {0.0 0.0 1.0}
mol clipplane status 3 5 top {0}
mol clipplane center 4 5 top {0.0 0.0 0.0}
mol clipplane color  4 5 top {0.5 0.5 0.5 }
mol clipplane normal 4 5 top {0.0 0.0 1.0}
mol clipplane status 4 5 top {0}
mol clipplane center 5 5 top {0.0 0.0 0.0}
mol clipplane color  5 5 top {0.5 0.5 0.5 }
mol clipplane normal 5 5 top {0.0 0.0 1.0}
mol clipplane status 5 5 top {0}
mol representation NewCartoon 0.300000 10.000000 4.100000 0
mol color ColorID 11
mol selection {residue 933 to 1243}
mol material Opaque
mol addrep top
mol selupdate 6 top 0
mol colupdate 6 top 0
mol scaleminmax top 6 0.000000 0.000000
mol smoothrep top 6 0
mol drawframes top 6 {now}
mol clipplane center 0 6 top {0.0 0.0 0.0}
mol clipplane color  0 6 top {0.5 0.5 0.5 }
mol clipplane normal 0 6 top {0.0 0.0 1.0}
mol clipplane status 0 6 top {0}
mol clipplane center 1 6 top {0.0 0.0 0.0}
mol clipplane color  1 6 top {0.5 0.5 0.5 }
mol clipplane normal 1 6 top {0.0 0.0 1.0}
mol clipplane status 1 6 top {0}
mol clipplane center 2 6 top {0.0 0.0 0.0}
mol clipplane color  2 6 top {0.5 0.5 0.5 }
mol clipplane normal 2 6 top {0.0 0.0 1.0}
mol clipplane status 2 6 top {0}
mol clipplane center 3 6 top {0.0 0.0 0.0}
mol clipplane color  3 6 top {0.5 0.5 0.5 }
mol clipplane normal 3 6 top {0.0 0.0 1.0}
mol clipplane status 3 6 top {0}
mol clipplane center 4 6 top {0.0 0.0 0.0}
mol clipplane color  4 6 top {0.5 0.5 0.5 }
mol clipplane normal 4 6 top {0.0 0.0 1.0}
mol clipplane status 4 6 top {0}
mol clipplane center 5 6 top {0.0 0.0 0.0}
mol clipplane color  5 6 top {0.5 0.5 0.5 }
mol clipplane normal 5 6 top {0.0 0.0 1.0}
mol clipplane status 5 6 top {0}
mol representation NewCartoon 0.300000 10.000000 4.100000 0
mol color ColorID 22
mol selection {residue 1244 to 1554}
mol material Opaque
mol addrep top
mol selupdate 7 top 0
mol colupdate 7 top 0
mol scaleminmax top 7 0.000000 0.000000
mol smoothrep top 7 0
mol drawframes top 7 {now}
mol clipplane center 0 7 top {0.0 0.0 0.0}
mol clipplane color  0 7 top {0.5 0.5 0.5 }
mol clipplane normal 0 7 top {0.0 0.0 1.0}
mol clipplane status 0 7 top {0}
mol clipplane center 1 7 top {0.0 0.0 0.0}
mol clipplane color  1 7 top {0.5 0.5 0.5 }
mol clipplane normal 1 7 top {0.0 0.0 1.0}
mol clipplane status 1 7 top {0}
mol clipplane center 2 7 top {0.0 0.0 0.0}
mol clipplane color  2 7 top {0.5 0.5 0.5 }
mol clipplane normal 2 7 top {0.0 0.0 1.0}
mol clipplane status 2 7 top {0}
mol clipplane center 3 7 top {0.0 0.0 0.0}
mol clipplane color  3 7 top {0.5 0.5 0.5 }
mol clipplane normal 3 7 top {0.0 0.0 1.0}
mol clipplane status 3 7 top {0}
mol clipplane center 4 7 top {0.0 0.0 0.0}
mol clipplane color  4 7 top {0.5 0.5 0.5 }
mol clipplane normal 4 7 top {0.0 0.0 1.0}
mol clipplane status 4 7 top {0}
mol clipplane center 5 7 top {0.0 0.0 0.0}
mol clipplane color  5 7 top {0.5 0.5 0.5 }
mol clipplane normal 5 7 top {0.0 0.0 1.0}
mol clipplane status 5 7 top {0}
