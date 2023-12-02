# The MIT License (MIT)
# Copyright © 2023 Raffaele Intorcia
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the “Software”),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

"""Module providingFunction printing python version."""
import sys
import os
import re
from pathlib import Path

def remove_assert(content):
    """Function printing python version."""
    # match .assert "macroName(x)", macroName(1), lda #0
    # on single line without curly braces
    content = re.sub(r".assert [^{}]*(?=\n|$)", r"", content)

    # match .assert "macroName(x)", { macroName(1) }, { lda #0 }
    # on single or multiple line with curly braces
    content = re.sub(r".assert [^\}]+\}[^\}]+\}", r"", content)

    return content

def remove_assert_error(content):
    """Function printing python version."""
    # match .asserterror "macroName(x)", { macroName(1) }
    content = re.sub(r".asserterror [^\}]+\}", r"", content)

    return content

def remove_filenamespace(content):
    """Function printing python version."""
    # remove filenamespace
    content = re.sub(r".filenamespace [\w]*\n", "", content)

    return content

def remove_importonce(content):
    """Function printing python version."""
    # remove importonce
    content = re.sub(r"#importonce[\w]*\n", "", content)

    return content

def remove_import(content):
    """Function printing python version."""
    # remove import
    content = re.sub(r"#import[^\"]+\"[^\"]+\"\n", "", content)

    return content

def remove_inital_dot_from_keywords(content):
    """Function printing python version."""
    # convert keywords to be interpreted by doxygen
    content = content.replace('.namespace ', 'namespace ')
    content = content.replace('.macro ', 'macro ')
    content = content.replace('.function ', 'function ')
    content = content.replace('.label ', 'label ')
    content = content.replace('.pseudocommand ', 'pseudocommand ')
    content = content.replace('.struct ', 'struct ')

    return content

def fix_struct_definition(content):
    """Function printing python version."""
    # add a comma on the last field definition on struct before
    # closing curly brace
    content = re.sub(r"((.struct)[\s@\w]+\{[^\}]+)", r"\1,", content)
    content = re.sub(r"((.struct)[\s@\w]+\{[^\}]+\})", r"\1;", content)

    return content

def add_semicolon_to_label_declaration(content):
    """Function printing python version."""
    # add semicolon at the end of label declaration
    content = re.sub(r'(label[^\n\,]+)', r'\1;', content)

    return content

def remove_some_newline(content):
    """Function printing python version."""
    content = re.sub(r"[\n]{2,}\/\*\*", r"\n\n/**", content)

    return content

def read_file(filename):
    """Function printing python version."""
    print("Processing " + filename)

    with open(filename, 'r', encoding='utf8') as file_to_open:
        return file_to_open.read()

def convert_file(content):
    """Function printing python version."""
    print("Editing...")

    content = remove_assert(content)

    content = remove_assert_error(content)

    content = remove_filenamespace(content)

    content = remove_importonce(content)

    content = remove_import(content)

    content = fix_struct_definition(content)

    content = remove_inital_dot_from_keywords(content)

    content = add_semicolon_to_label_declaration(content)

    content = remove_some_newline(content)
    return content

def write_file(filename, content):
    """Function printing python version."""
    head, tail = os.path.split(filename)

    output_filename = head + '/output/' + tail

    print("Saving " + output_filename + "...")
    with open(output_filename, 'w', encoding='utf8') as out_file:
        out_file.write(content)
        out_file.close()

def usage():
    """Function printing python version."""
    print("Convert KickAssembler source code into C-like format")
    print("readable from Doxygen.")
    print("Converted files are not meant to contain valid source")
    print("code.")
    print("Output files will be automatically created in ")
    print("\"output\" folder inside folder passed by argument.")
    print()
    print("Usage: " + sys.argv[0] + " <folder-name>")
    print()
    print("Example: " + sys.argv[0] + " .\\lib")
    print("Remeber to use slash or backslash correctly.")

if len(sys.argv) == 1:
    print(usage())
else:
    print("Using " + sys.argv[1] + " command line arguments")
    head_argument, tail_argument = os.path.split(sys.argv[1])
    if os.path.isdir(head_argument + '/output') is False:
        print("Creating " + head_argument + '/output')
        os.makedirs(head_argument + '/output', exist_ok=True)

    for file in Path(sys.argv[1]).glob("*.asm"):
        if os.path.isdir(file) is False:
            content_to_elaborate = read_file(str(file))
            content_to_elaborate = convert_file(content_to_elaborate)
            write_file(str(file), content_to_elaborate)
