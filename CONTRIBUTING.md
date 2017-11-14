# Contributing to the 49th Security Division's Slideshows

I'm really glad you're reading this, because we need the security community to help out as much as possible! We will always be open to taking suggestions, constructive criticism, and any help at all!

## Adding to the slideshows

### Prerequisites
* [Reveal.js](https://github.com/hakimel/reveal.js) - Slideshow HTML5 platform for github
* [Slides.com](https://slides.com/) - PDF and PowerPoint converter/ease of creating reveal.js slideshows
* git

### Guidelines
#### General 49th meetings
I use my admining scripts of `github-pages-slides.sh` and `github-pages.sh` to be able to automate the creation of the README.md's, directories, and reveal.js directory. For general classes there will be three folder Beginner, Intermediate, and Advanced/Speakers. Follow the process below to put it in the proper folders which will take up from 00-->02.

This is the process of putting slides up on github.
1. Got to [Slides.com](https://slides.com/)
2. Create powerpoint on Slides.com
3. Create a google shortend link for live presentations
4. Present live
5. Add README.md on the master branch with the `github-pages.sh` script.
6. push everything up to github `cd $(root of slideshows directory)` --> `git add .` --> `git commit -m 'note'` --> `git push` make sure this is done first, because it will mess up the other branches of your github repository if you don't
7. `git checkout gh-pages`
8. Create reveal.js template with `github-pages-slides.sh`
9. Export slides.com presentation to index.html in the reveal.js template folder.
10. `cd $(root of slideshows directory)` --> `git add .` --> `git commit -m 'note'` --> `git push`

#### Non-general slideshows by 49th members
This folder will be 03 and will be called Community. It will be for presentations that 49th members either do with other UNC Charlotte organizations or with any other community events (Science fair,Cybersecurity 101's, etc...). Follow the same process above.

#### External Classes slideshows
This folder will be 04 and will be called Conferences-Classes. It will be for presentations that were done for Conferences, ISSA classes, and other educational opportunities. Even though we might not be able to post the exact slides because of the author not wanting it. We can still post personal notes that we took (with the consent of the author) to allow the further education of the cybersecurity community.


## Suggestions
If there is a topic that has not been discussed/presented. Please submit an [issue](https://github.com/49thSecurityDivision/slideshows/issues) and tag it with the [Topic Suggestion](https://github.com/49thSecurityDivision/slideshows/labels/Topic%20Suggestion) label
