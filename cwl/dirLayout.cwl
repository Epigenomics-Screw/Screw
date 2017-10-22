cwlVersion: v1.0
class: ExpressionTool

requirements:
  InlineJavascriptRequirement: {}

inputs:
  a:
    type: File

expression: |
  ${ var run_id = inputs.actual_run_id + "_MERGED_FASTQ";
     inputs.krona_input.basename = "krona-input.txt";

     var r = {
       "outputs":
         { "class": "Directory",
           "basename": run_id,
           "listing": [
             { "class": "Directory",
               "basename": "taxonomy-summary",
               "listing": [
                 inputs.krona_input,
                 inputs.kingdom_counts,
                 inputs.otu_visualization ] },
             { "class": "Directory",
               "basename": "qc-statistics",
               "listing": [
                 inputs.qc_stats_summary,
                 inputs.qc_stats_seq_len_pbcbin,
                 inputs.qc_stats_seq_len_bin,
                 inputs.qc_stats_seq_len,
                 inputs.qc_stats_nuc_dist,
                 inputs.qc_stats_gc_pcbin,
                 inputs.qc_stats_gc_bin,
                 inputs.qc_stats_gc ] },
             { "class": "Directory",
               "basename": "sequence-categorisation",
               "listing": [
                 inputs["16S_matches"],
                 inputs["23S_matches"],
                 inputs["5S_matches"],
                 inputs.interproscan_matches,
                 inputs.no_functions_seqs,
                 inputs.pCDS_seqs
              ] },
             { "class": "Directory",
               "basename": "cr_otus",
               "listing": [
                 { "class": "Directory",
                   "basename": "uclust_ref_picked_otus",
                   "listing": [
                     inputs["qiime_sequences-filtered_clusters"],
                     inputs["qiime_sequences-filtered_otus"]
                   ] },
                 inputs.tree,
                 inputs.biom_json,
                 inputs.biom_hdf5,
                 inputs.biom_tsv,
                 inputs.qiime_assigned_taxonomy
               ] },
             inputs.post_qc_reads,
             { "class": "File",
               "contents": inputs.post_qc_read_count.toString(),
               "basename": run_id + ".fasta.submitted.count" },
             inputs.processed_sequences,
             inputs.functional_annotations,
             inputs.go_summary,
             inputs.go_summary_slim,
             inputs.annotated_CDS_nuc,
             inputs.annotated_CDS_aa,
             inputs.unannotated_CDS_nuc,
             inputs.unannotated_CDS_aa,
             inputs.ipr_summary,
             inputs.summary
             ] } };
     return r; }

outputs:
  results: Directory