#!/bin/bash                                                                        
### GitHubRating, by Daniel Miessler
### Rank one's programming activity.

# Variables

USERNAME=$1
SITENAME=$1
URL=''
RESPONSECODE=''

# Get page
	
curl -sLA "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/600.1.25 (KHTML, like Gecko) Version/8.0 Safari/600.1.25"  https://github.com/$USERNAME > $SITENAME-page.htm

# Get followers 

	grep -i "vcard-stat-count" $SITENAME-page.htm | head -n 1 > $SITENAME-followers.txt
    FOLLOWERS=`sed -e 's/\(.*\)>\([0-9\.a-zA-Z]*\)<\(.*\)/\2/' $SITENAME-followers.txt | awk '{ print $1 }'`

# Get contributions

	grep -i "contributions in the last year" $SITENAME-page.htm | head -n 1 > $SITENAME-yearcontrib.txt
    CONTRIBS=`sed -e 's/\( *\)\([0-9,]\+\)\(.*\)/\2/' $SITENAME-yearcontrib.txt`

# Get repositories

	grep -i "repositories written" $SITENAME-page.htm | head -n 1 > $SITENAME-repositories.txt
    REPOS=`sed -e 's/.*has\(.*\)repositories.*/\1/' $SITENAME-repositories.txt | awk '{ print $1 }'`

# Calculate score

NEWFOLLOWERS=`echo "$FOLLOWERS * 5" | sed -e 's/k/*1000/' | bc`
NEWFOLLOWERS=`echo "$NEWFOLLOWERS/1" | bc`
NEWCONTRIBS=`echo "$CONTRIBS * 1" |  sed -e 's/,//' | bc`
NEWREPOS=`echo "$REPOS * 3" | bc`
SCORE=`echo "$NEWFOLLOWERS + $NEWCONTRIBS + $NEWREPOS" | bc`

# Reporting
	echo ""
	echo ""$SITENAME" has:"
	echo ""
	echo ""$FOLLOWERS" followers."
	echo ""$CONTRIBS" public pushes this year."
	echo ""$REPOS" public repositories."
    echo ""                                                                        
    echo "Developer rating (based on public contributions only): "$SCORE""

# Help if no arguments                                                             

if [[ $# -ne 1 ]] ; then
	echo ''
    echo 'Usage:'
	echo './GitHubRating.sh githubusername, e.g.: ./GitHubRating.sh danielmiessler'
	echo ''
    exit 0
else
    USERNAME="$1"
fi 
