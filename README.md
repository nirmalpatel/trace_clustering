# Trace clustering
This repository includes programs for clustering event logs and related things.

Trace clustering refers to clustering of event logs. Since my work is related to educational data mining (or EDM), in that context, trace clustering means clustering students based on their activity sequences. In my analyses of eLearning software data, I have found that there can be tens of thousands of unique learning paths present in an eLearning environment. It is natural that no two students will follow same learning path, but it is also intuitive that many students will have similar paths (consider students in a same class, being taught by same teacher). Clustering students based on activity sequence lets us group them in a novel way.

Clustering is generally useful method in EDM, because it lets us discover groups of students who exhibit similar behavior. If we can cluster activity trails of students, we can find students who following similar learning paths. Afterwards, we can look at properties of clusters obtained. This can inform product designers, and tell them different ways product is used. This can also inform educators and decision makers who would like to know sequence that students follow, and outcomes related to each of them.

Methods like K-Means clustering can not be of much use if data points we have are not naturally represented in Euclidian space. Also, temporal information is lost when we try to use K-Means clustering to cluster sequences. In contrast, trace clustering algorithm presented here preserves temporal information. At the core, it uses different string distance metrics to produce pairwise distances between traces, and uses that information to perform agglomerative hierarchical clustering. There is no magic to it, in fact, the whole implementation is quite simple.

If you would like to know more about this work, you can email me at message.nirmal@gmail.com
