#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: ExpressionTool
requirements:
  InlineJavascriptRequirement: {}
label: Convert a Directory to an array of Files, skipping subfolders

inputs:
  directory:
    type: Directory

expression: |
  ${
      var i, len = inputs.directory.listing.length;
      for (i = len - 1; i >= 0; i--) {
         if (inputs.directory.listing[i].class != 'File') {
            inputs.directory.listing.splice(i, 1);
         }
      }
      return { "array_of_files": inputs.directory.listing };
  }

outputs:
  array_of_files:
    type: File[]
