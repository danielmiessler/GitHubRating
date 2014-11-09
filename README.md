GitHubRating
============

Whether you're hiring an actual developer or just someone who needs to know how to code to solve problems, it's useful to get a feel for how much coding they actually do.

This tool runs from the command line and takes a single parameter: the github username of the person you're looking into. The result is a composite score for their programming quality on GitHub. It's not their number of repos, or their followers, or their number of code pushes&mdash;it's all of those things combined and weighted.

## Usage

Example:

<code>./GitHubRating.sh danielmiessler</code>

Example Output:

> danielmiessler has:<br />

> 131 followers.<br />
> 352 pushes this year.<br />
> 32 repositories.<br />
<br />
> Github score is: 1287
