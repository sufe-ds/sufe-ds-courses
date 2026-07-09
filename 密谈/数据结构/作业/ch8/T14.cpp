#include <cstddef>
#include <iostream>
#include <queue>

constexpr size_t MAX_NODE = 1000;
constexpr size_t MAX_EDGE = 10000;

class UnionFindSet {
 public:
  UnionFindSet() {
    for (size_t i = 0; i < MAX_NODE; ++i) {
      parent[i] = i;
      rank[i] = 0;
    }
  }

  void unite(size_t x, size_t y) {
    size_t rootX = find(x);
    size_t rootY = find(y);
    if (rootX != rootY) {
      if (rank[rootX] < rank[rootY]) {
        parent[rootX] = rootY;
      } else if (rank[rootX] > rank[rootY]) {
        parent[rootY] = rootX;
      } else {
        parent[rootY] = rootX;
        rank[rootX]++;
      }
    }
  }

  bool connected(size_t x, size_t y) { return find(x) == find(y); }

 private:
  size_t parent[MAX_NODE];
  size_t rank[MAX_NODE];

  size_t find(size_t x) {
    if (parent[x] != x) {
      parent[x] = find(parent[x]);
    }
    return parent[x];
  }
};

template <typename T>
struct Edge {
  size_t from;
  size_t to;
  T weight;
  size_t next;

  bool operator>(const Edge& other) const { return weight > other.weight; }
};

template <typename T>
class Graph {
 public:
  Graph() : nodeCount(0), edgeCount(0) {
    for (size_t i = 0; i < MAX_NODE; ++i)
      head[i] = 0;
  }

  void addSingleEdge(size_t from, size_t to, T weight) {
    if (head[from] == 0)
      nodeCount++;
    if (head[to] == 0)
      nodeCount++;
    edges[++edgeCount] = {from, to, weight, head[from]};
    head[from] = edgeCount;
  }
  void addDoubleEdge(size_t from, size_t to, T weight) {
    if (head[from] == 0)
      nodeCount++;
    if (head[to] == 0)
      nodeCount++;

    edges[++edgeCount] = {from, to, weight, head[from]};
    head[from] = edgeCount;
    edges[++edgeCount] = {to, from, weight, head[to]};
    head[to] = edgeCount;
  }

  Graph mstKruskal() {
    Graph<T> mst;
    UnionFindSet ufs;
    std::priority_queue<Edge<T>, std::vector<Edge<T>>, std::greater<Edge<T>>>
        edgeHeap;

    for (size_t i = 1; i <= edgeCount; ++i)
      edgeHeap.push(edges[i]);

    while (!edgeHeap.empty()) {
      auto edge = edgeHeap.top();
      edgeHeap.pop();
      if (!ufs.connected(edge.from, edge.to)) {
        ufs.unite(edge.from, edge.to);
        mst.addSingleEdge(edge.from, edge.to, edge.weight);
      }
    }
    return mst;
  }

  void printGraph() {
    for (size_t i = 0; i < MAX_NODE; ++i) {
      if (head[i] != 0) {
        std::cout << "Node " << i << ": ";
        size_t edgeIndex = head[i];
        while (edgeIndex != 0) {
          const auto& edge = edges[edgeIndex];
          std::cout << "-> (to: " << edge.to << ", weight: " << edge.weight
                    << ") ";
          edgeIndex = edge.next;
        }
        std::cout << std::endl;
      }
    }
  }

 private:
  size_t nodeCount;
  size_t edgeCount;
  size_t head[MAX_NODE];
  Edge<T> edges[MAX_EDGE];
};

int main() {
  Graph<int> graph;
  graph.addDoubleEdge(0, 1, 10);
  graph.addDoubleEdge(0, 2, 6);
  graph.addDoubleEdge(0, 3, 5);
  graph.addDoubleEdge(1, 3, 15);
  graph.addDoubleEdge(2, 3, 4);

  std::cout << "Original Graph:" << std::endl;
  graph.printGraph();

  std::cout << "Minimum Spanning Tree (Kruskal's Algorithm):" << std::endl;
  graph.mstKruskal().printGraph();
  return 0;
}