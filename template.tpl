___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Reading Time Calculator",
  "categories": [
    "UTILITY"
  ],
  "description": "Returns reading time of text or DOM element variable in minutes, seconds or milliseconds",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "mainContentElement",
    "displayName": "Main Content Element",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "wordsPerMinute",
    "displayName": "Words Per Minute",
    "simpleValueType": true,
    "defaultValue": 350,
    "help": "Average reading speed for calculation",
    "alwaysInSummary": true,
    "valueValidators": [
      {
        "type": "POSITIVE_NUMBER"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "minSecs",
    "displayName": "Minimum Seconds",
    "simpleValueType": true,
    "defaultValue": 30,
    "help": "Minimal value to return in case of short content. Only used if main content element exists (0 if not)",
    "alwaysInSummary": true,
    "valueValidators": [
      {
        "type": "POSITIVE_NUMBER"
      }
    ]
  },
  {
    "type": "SELECT",
    "name": "resultFormat",
    "displayName": "Result Format",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "milli",
        "displayValue": "Milliseconds"
      },
      {
        "value": "sec",
        "displayValue": "Seconds"
      },
      {
        "value": "min",
        "displayValue": "Minutes"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "milli"
  },
  {
    "type": "CHECKBOX",
    "name": "addUnitName",
    "checkboxText": "Append Unit Name",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "unitName",
    "displayName": "Unit Name",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "addUnitName",
        "paramValue": true,
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const Math = require('Math');
var txt = data.mainContentElement;
var res = 0;
if (txt) {
  var lng = txt.split(" ").length;
  var txt_min = lng / data.wordsPerMinute||350;
  if (data.resultFormat === "min") res = Math.max(Math.round(txt_min), Math.round((data.minSecs||30) / 60)); 
  else if (data.resultFormat === "sec") res = Math.max(Math.round(txt_min * 60), data.minSecs||30);
  else res = Math.round(Math.max(txt_min * 60, data.minSecs||30) * 1000);
}  

if ((data.addUnitName === true) && (data.unitName)) res = res + " " + data.unitName;

return res;


___TESTS___

scenarios:
- name: Seconds (raw)
  code: |-
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(79);
- name: Seconds (with unit)
  code: |-
    mockData.addUnitName = true;
    mockData.unitName = "Seconds";

    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo("79 Seconds");
- name: Seconds (below min value)
  code: |-
    mockData.mainContentElement = "there is no place like 127.0.0.1";

    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(30);
- name: Minutes (raw)
  code: |-
    mockData.resultFormat = "min";

    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(1);
- name: Milliseconds (raw)
  code: |-
    mockData.resultFormat = "milli";

    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(79371);
setup: |-
  var txt = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ut metus in lacus vestibulum laoreet. Nam euismod laoreet tincidunt. Pellentesque in nibh id sem accumsan malesuada. Suspendisse erat nisi, pretium vel sem at, maximus accumsan justo. Nam quis nibh vehicula, blandit velit et, ullamcorper mi. In ac leo arcu. Duis metus odio, aliquam eget rutrum sed, rutrum efficitur sapien. Morbi viverra magna arcu, vitae pretium est aliquet feugiat. Donec arcu sapien, condimentum at arcu vel, dapibus cursus libero.';
  var mockData = {
    mainContentElement: txt + txt + txt + txt + txt + txt,
    wordsPerMinute: 350,
    minSecs: 30,
    resultFormat: "sec",
    addUnitName: false
  };


___NOTES___

Created on 24.8.2022, 00:55:58
