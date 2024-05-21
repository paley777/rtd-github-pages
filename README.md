                          
<h1 align="center" style="font-weight: bold;">Continuous Documentation Repository 💻</h1>


<p align="center">This repository provides a way to automate the creation of documentation for an application.</p>


<p align="center">
<a href="https://paley777.github.io/rtd-github-pages/">📱 Results in this Link!</a>
</p>
 
<h2 id="started">🚀 Getting started</h2>

The process of automating this documentation creation is:
1. Generate documentation (sphinx-docs) automatically when a commit is pushed to the repository.
2. After being generated automatically, the results of the html documentation build are moved to a new branch called "gh-pages".
3. We have set the branch as a Github Pages so that it can be used to host the documentation.
4. All the processes above occur repeatedly when there are changes via push commit automatically. Without the need to change rst files.

Files used:
1. docs_pages_workflow.yml as a file executed by GitHub Actions.
2. buildDocs.sh as a script to build documentation and push it to the "gh-pages" branch.
 
<h2 id="technologies">💻 Technologies</h2>

- Sphinx Docs
- Read the Docs
- GitHub Actions
- GitHub Pages
