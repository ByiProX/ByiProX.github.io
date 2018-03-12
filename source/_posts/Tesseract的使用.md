---
title: Tesseract的使用
date: 2018-03-12 12:35:36
tags:
  - Tesseract
categories:
  - Tesseract
---

## Running Tesseract with command-line

Tesseract is a command-line program, so first open a terminal or command prompt. The command is used like this:
```bash    
tesseract imagename outputbase [-l lang] [-psm pagesegmode] [configfile...]
```
So basic usage to do OCR on an image called 'myscan.png' and save the result to 'out.txt' would be:
```bash    
tesseract myscan.png out
```
Or to do the same with German:
```bash   
tesseract myscan.png out -l deu
```
It can even be used with multiple languages traineddata at a time eg. English and German:
```bash
     tesseract myscan.png out -l eng+deu
```
Tesseract also includes a hOCR mode, which produces a special HTML file with the coordinates of each word. This can be used to create a searchable pdf, using a tool such as [Hocr2PDF](https://exactcode.com/opensource/exactimage/). To use it, use the 'hocr' config option, like this:
```bash    
tesseract myscan.png out hocr
```
You can also create a searchable pdf directly from tesseract ( versions >=3.03):
```bash    
tesseract myscan.png out pdf
```
More information about the various options is available in the [Tesseract manpage](https://github.com/tesseract-ocr/tesseract/blob/master/doc/tesseract.1.asc).

### Other Languages

Tesseract has been trained for [many languages](https://github.com/tesseract-ocr/tesseract/blob/master/doc/tesseract.1.asc#languages), check for your language in the [Tessdata repository](https://github.com/tesseract-ocr/tessdata).

For example, if we want Tesseract support Chinese language, just put `chi_sim.traineddata` into the path `/usr/local/Cellar/tesseract/3.05.01/share/tessdata/`。

It can also be trained to support other languages and scripts; for more details see [TrainingTesseract](https://github.com/tesseract-ocr/tesseract/wiki/TrainingTesseract).


## Running Tesseract with Python
Python-tesseract is an optical character recognition (OCR) tool for python. That is, it will recognize and "read" the text embedded in images.

### Usage
** Quick start **
```Python
try:
    import Image
except ImportError:
    from PIL import Image
import pytesseract

pytesseract.pytesseract.tesseract_cmd = '<full_path_to_your_tesseract_executable>'
# Include the above line, if you don't have tesseract executable in your PATH
# Example tesseract_cmd: 'C:\\Program Files (x86)\\Tesseract-OCR\\tesseract'

# Simple image to string
print(pytesseract.image_to_string(Image.open('test.png')))

# French text image to string
print(pytesseract.image_to_string(Image.open('test-european.jpg'), lang='fra'))

# Get bounding box estimates
print(pytesseract.image_to_boxes(Image.open('test.png')))

# Get verbose data including boxes, confidences, line and page numbers
print(pytesseract.image_to_data(Image.open('test.png')))
```
Support for OpenCV image/NumPy array objects
```python
import cv2

img = cv2.imread('/**path_to_image**/digits.png')
print(pytesseract.image_to_string(img))
# OR explicit beforehand converting
print(pytesseract.image_to_string(Image.fromarray(img))
```
Add the following config, if you have tessdata error like: "Error opening data file..."
```python
tessdata_dir_config = '--tessdata-dir "<replace_with_your_tessdata_dir_path>"'
# Example config: '--tessdata-dir "C:\\Program Files (x86)\\Tesseract-OCR\\tessdata"'
# It's important to add double quotes around the dir path.

pytesseract.image_to_string(image, lang='chi_sim', config=tessdata_dir_config)

```

**Functions**

- **image_to_string** Returns the result of a Tesseract OCR run on the image to string
- **image_to_boxes** Returns result containing recognized characters and their box boundaries
- **image_to_data** Returns result containing box boundaries, confidences, and other information. Requires Tesseract 3.05+. For more information, please check the [Tesseract TSV documentation](https://github.com/tesseract-ocr/tesseract/wiki/Command-Line-Usage#tsv-output-currently-available-in-305-dev-in-master-branch-on-github)

**Parameters**

`image_to_data(image, lang=None, config='', nice=0, output_type=Output.STRING)`

- **image** Object, PIL Image/NumPy array of the image to be processed by Tesseract
- **lang** String, Tesseract language code string
- **config** String, Any additional configurations as a string, ex: `config='--psm 6'`
- **nice** Integer, modifies the processor priority for the Tesseract run. Not supported on Windows. Nice adjusts the niceness of unix-like processes.
- **output_type** Class attribute, specifies the type of the output, defaults to `string`. For the full list of all supported types, please check the definition of [pytesseract.Output](https://github.com/madmaze/pytesseract/blob/master/src/pytesseract.py) class.
