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

def replace_body_in_curly_brackets(string_to_elaborate):
    """Function printing python version."""
    new_string_to_elaborate = re.sub(r"(\{[^\{\}]*\})", r";", string_to_elaborate)
    while new_string_to_elaborate != string_to_elaborate:
        string_to_elaborate = new_string_to_elaborate
        new_string_to_elaborate = re.sub(r"(\{[^\{\}]*\})", r";", string_to_elaborate)

    return string_to_elaborate

def remove_assert(content):
    """Function printing python version."""
    # match .assert "macroName(x)", { macroName(1) }, { lda #1 }
    content = re.sub(r".assert [\.\|\"\w\(\)\,\s+\{\}\%\#\$\;\[\]]+\}", "", content)

    # match .assert "macroName(x)", macroName(1), 1
    content = re.sub(r"(.assert [^\,]+\,[^\,]+\,[^\n]+)", r"", content)

    return content

def remove_assert_error(content):
    """Function printing python version."""
    # match .asserterror "macroName(x)", { macroName(1) }
    content = re.sub(r"(.asserterror [^\,]+\,[^\}]+\})", r"", content)

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
    content = re.sub(r"#import[\w\"\\\/\.\s]*\n", "", content)

    return content

def remove_inital_dot_from_keywords(content):
    """Function printing python version."""
    # convert keywords to be interpreted by doxygen
    content = content.replace('.namespace ', 'namespace ')
    content = content.replace('.macro ', 'macro ')
    content = content.replace('.function ', 'function ')
    content = content.replace('.label ', 'label ')
    content = content.replace('.pseudocommand ', 'pseudocommand ')

    return content

def add_semicolor_to_label_declaration(content):
    """Function printing python version."""
    # add semicolor at the end of label declaration
    content = re.sub(r'(label[^\n]+)', r'\1;', content)

    return content

def convert_file(filename):
    """Function printing python version."""
    print("Processing " + filename)
    head, tail = os.path.split(filename)

    output_filename = head + '/output/' + tail

    print("Reading...")
    content = open(filename, 'r', encoding='utf8').read()

    print("Editing...")

    content = remove_assert(content)

    content = remove_assert_error(content)

    content = remove_filenamespace(content)

    content = remove_importonce(content)

    content = remove_import(content)

    # we need to clean macro/function body, but first check if there
    # is a namespace (we don't have to clean namespace body)
    namespace_index = content.find(".namespace ")
    if namespace_index != -1:
        # there is a namespace, preserve it and clean any body inside it
        namespace_index = content.find("{", namespace_index) + 1
        content_in_namespace = content[namespace_index:]

        content_in_namespace_replaced = replace_body_in_curly_brackets(content_in_namespace)

        content = content.replace(content_in_namespace, content_in_namespace_replaced)
    else:
        # there is no namespace, clean all bodies
        content = replace_body_in_curly_brackets(content)

    content = remove_inital_dot_from_keywords(content)

    content = add_semicolor_to_label_declaration(content)

    # finish... save the new file
    print("Saving " + output_filename + "...")
    out_file = open(output_filename, 'w', encoding='utf8')
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
            convert_file(str(file))
