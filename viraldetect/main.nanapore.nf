#!/usr/bin/env nextflow
// Create a nextflow channel from fastq files
samples = Channel.fromPath ("${params.in_dir}/*.fastq.gz")

<<<<<<< HEAD
=======
samples.into { samples_1; samples_2 }


>>>>>>> 7fe7644b5e66dd0e20320521cc855db062f7639b
// Run Kraken
process runKraken {
    tag { "${sample}.runKraken" }
    memory { 4.GB * task.attempt }
    cpus { 8 }
    publishDir "${params.out_dir}/${sample}", mode: 'copy', overwrite: false
    module 'bioinf'
    
    input:
<<<<<<< HEAD
    file(sample) from samples
=======
    file(sample) from samples_1
>>>>>>> 7fe7644b5e66dd0e20320521cc855db062f7639b
    
    output:
    file "kraken-hits.tsv" into kraken_hits   
 
    script:
    """
    kraken2 --memory-mapping --quick \
    --db ${params.kraken_db} \
    --threads ${task.cpus} \
    --report kraken-hits.tsv \
    ${sample} 
    """
}

/*
// Filter out reads that match
process filterHumanReads {
    input:
   // Kraken file

   output:
   file "clean.fastq" into clean_fq
   // Original Kraken output file witout human reads

   script:
   """
   // Remove possible human reads from Kraken output
   """
}
<<<<<<< HEAD

process runMinimap2 {
    input:
    file fastq from clean_fq

    output:
    file "minimap2.bam" into bam

    script:
    """
    // Run minimap2
    """
}


// Here we should pull in Kraken, Mappingstats and Krona visualisation. Are we still running Krona
=======
*/

process runMinimap2 {
    tag { "${sample}.runMinimap2" }
    memory { 4.GB * task.attempt }
    cpus { 8 }
    publishDir "${params.out_dir}/${sample}", mode: 'copy', overwrite: false
    module 'bioinf'
    
    input:
    file(sample) from samples_2
    
    output:
    file "minimap2.sam" into minimap2   
 
    script:
    """
    minimap2 -a  ${params.minimap2_db}  ${sample} > minimap2.sam
    """
}

/*
// Here we should pull in Kraken, Mappingstats and Krona visualisation. 
>>>>>>> 7fe7644b5e66dd0e20320521cc855db062f7639b
process generateReport {

    input:
    // Kraken output without human reads
    // minimap2 bam

    output:
    // Report.tsv

    script:
    """
    /// Need to run a custom script here that validates the minimap2 against the Kraken results and create a report with high confident hits.
    """
}
*/