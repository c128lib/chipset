import glob, os
import shutil
import sys
import re

def convertFile(filename):
  print("Processing " + filename)
  head, tail = os.path.split(filename)

  outputFileName = head + '/output/' + tail

  print("Reading...")
  content = open(filename, 'r').read()

  print("Editing...")
  # convert keywords to be interpreted by doxygen
  content = content.replace('.namespace ', 'namespace ')
  content = content.replace('.macro ', 'macro ')
  content = content.replace('.function ', 'function ')

  # remove filenamespace
  content = re.sub(".filenamespace [\w]*\n", "", content)
  # remove importonce
  content = re.sub("#importonce[\w]*\n", "", content)
  # remove import
  content = re.sub("#import[\w\"\\\/\.\s]*\n", "", content)

  # match .assert "macroName(x)", { macroName(1) }, { lda #1 }
  content = re.sub(".assert [\.\|\"\w\(\)\,\s+\{\}\%\#\$\;]+\}", "", content)

  # match .assert "macroName(x)", macroName(1), 1
  content = re.sub(".assert \"{1}[^\"]+\"\,\s*[^\)]+\)\,\s+[\$\%\w]+", "", content)

  # add semicolor at the end of label declaration
  content = re.sub(r'.(label[^\n]+)', r'\1;', content)

  print("Saving " + outputFileName + "...")
  f = open(outputFileName, 'w')
  f.write(content)
  f.close()

head, tail = os.path.split(sys.argv[1])
print("Creating " + head + '/output/')
os.makedirs(head + '/output/', exist_ok=True)

for file in glob.glob(sys.argv[1]):
  convertFile(file)
