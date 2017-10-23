cwlVersion: v1.0
class: ExpressionTool

requirements:
  InlineJavascriptRequirement: {}

inputs:
  meth: File[]
  meth_sym: File[]
  prop_meth: File[]
  cov_bw: File[]
  subset: File[]
  distanceMatrix: File
  heatMap: File

# TODO: Testing
expression: |
  ${ 
    // to include: meth meth_sym prop_meth cov_bw subset cluster
    var r = {
      "outputs":

        { "class": "Directory",
          "basename": "results",
          "listing": [

            { "class": "Directory",
              "basename": "meth",
              "listing": [
                inputs.meth, ] 
            },
            { "class": "Directory",
              "basename": "meth_sym",
              "listing": [
                inputs.meth_sym ] 
            },
            { "class": "Directory",
              "basename": "prop_meth",
              "listing": [
                inputs.prop_meth ] 
            },
            { "class": "Directory",
              "basename": "cov_bw",
              "listing": [
                inputs.cov_bw ] 
            },
            { "class": "Directory",
              "basename": "subset",
              "listing": [
                inputs.subset ] 
            },

            inputs.distanceMatrix,
            inputs.heatMap
          ] 
        } 
    };
    return r; 
  }

outputs:
  results: Directory