Hi! I am a markdown file with some broken links for testing purposes.
I will be removed once the test is complete.

### Links & Results

| Expectation | Local | GH Action | Link                                                                                 |
|-------------|-------|-----------|--------------------------------------------------------------------------------------|
|ERROR        | PASS  | PASS      | [link](https://www.infineon.com/cms/en/product/evaluation-boards/bldc_shield_tle9879)|
|FOUND        | PASS  | tbd       | [link](https://www.infineon.com)                                                     |
|ERROR        | FAIL  | FAIL      | [link](htts://www.infineon.com)                                                      |
|ERROR        | PASS  | PASS      | [link](https://www.infieon.com)                                                      |
|ERROR        | PASS  | PASS      | [link](https:/d/www.infineon.com)                                                    |
|ERROR        | FAIL  | FAIL      | [link](https:///www.infineon.com)                                                    |
|ERROR        | FAIL  | FAIL      | [link](https:/www.infineon.com)                                                      |
|FOUND        | PASS  | PASS      | [link](https://img.shields.io/badge/build-passing-brightgreen)                       |
|ERROR        | PASS  | PASS      | [link](https://img.shilds.io/badge/build-passing-brightgreen)                        |
|FOUND        | PASS  | PASS      | [link](README.md)                                                                    |
|ERROR        | PASS  | PASS      | [link](CODEOWNER)                                                                    |