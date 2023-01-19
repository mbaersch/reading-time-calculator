# Reading Time Calculator 

**Custom Variable Template for Google Tag Manager**

Variable Template for calculating reading time for a text or DOM element content

[![Template Status](https://img.shields.io/badge/Community%20Template%20Gallery%20Status-published-green)](https://tagmanager.google.com/gallery/#/owners/mbaersch/templates/reading-time-calculator) ![Repo Size](https://img.shields.io/github/repo-size/mbaersch/reading-time-calculator) ![License](https://img.shields.io/github/license/mbaersch/reading-time-calculator)

---

## Usage
- find your main content DOM element that contains all relevant content in your source code 

- create a DOM element variable that selects the main content element by ID or CSS selector. Tip: use `document.querySelector` in the console to check if your selector returns the right element 

- import this template and create a new variable using the template

- reference the DOM element variable (or a text from any other source) in the first field, set reading speed and min value

- change result format and optionally add a unit text as suffix for the result (which will change the format from integer to string)

The return value will contain the rounded amount of minutes, seconds or milliseconds (to feed a timer for example). If the input text / DOM element is undefined or empty, the result will be 0 (regardless of the defined minimum duration in seconds).  

