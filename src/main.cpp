#include <cstdio>
#include <vector>
#include <string>
#include "../cpppoa/src/poa.hpp"
#include "../cpppoa/src/graph.hpp"

using namespace std;
using namespace POA;

int main(int argc, char **argv) {
  char *id = new char[4096];
  char *seq = new char[1000000];

  vector<string> sequences;

  while (scanf("%s %s", id, seq) >= 0) {
    printf("%s\n", seq);
    sequences.push_back(string(seq));
  }

  Graph graph(sequences[0], "seq0");

  for (size_t i = 1; i < sequences.size(); ++i) {
    Alignment aln(const_cast<string&>(sequences[i]), graph);
    aln.align();
    graph.insertSequenceAlignment(aln, sequences[i], "seq" + to_string(i));
  }

  graph.alignment_strings();
  string consensus;
  graph.generate_consensus(&consensus);
  printf("%s", consensus.c_str());
}
