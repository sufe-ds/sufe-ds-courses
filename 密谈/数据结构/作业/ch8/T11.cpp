#include <cstddef>
#include <iostream>
#include <stack>
#include <vector>

constexpr size_t MAX_NODE = 1000;

template <typename T>
struct Edge {
  size_t from;
  size_t to;
  T weight;
};

template <typename T>
class Graph {
 public:
  void addSingleEdge(size_t from, size_t to, T weight) {
    if (G[from].empty())
      nodeCount++;
    if (G[to].empty())
      nodeCount++;

    G[from].push_back({from, to, weight});
  }

  void addDoubleEdge(size_t from, size_t to, T weight) {
    if (G[from].empty())
      nodeCount++;
    if (G[to].empty())
      nodeCount++;

    G[from].push_back({from, to, weight});
    G[to].push_back({to, from, weight});
  }

  const std::vector<Edge<T>>& getEdges(size_t node) const { return G[node]; }

  bool isConnected() const {
    std::vector<bool> visited(MAX_NODE, false);
    std::stack<size_t> recursionStack;

    recursionStack.push(0);
    visited[0] = true;

    size_t visitedCount = 1;

    while (!recursionStack.empty()) {
      size_t currentNode = recursionStack.top();
      recursionStack.pop();
      for (const auto& edge : G[currentNode]) {
        if (!visited[edge.to]) {
          visited[edge.to] = true;
          visitedCount++;
          recursionStack.push(edge.to);
        }
      }
    }

    return visitedCount == nodeCount;
  }

 private:
  std::vector<Edge<T>> G[MAX_NODE];
  size_t nodeCount = 0;
};

template <typename T>
void testIsConnected(const Graph<T>& graph, std::string graphName) {
  std::cout << graphName
            << " is connected: " << (graph.isConnected() ? "Yes" : "No")
            << std::endl;
}

int main() {
  Graph<bool> connectedGraph;
  connectedGraph.addDoubleEdge(0, 1, true);
  connectedGraph.addDoubleEdge(1, 2, true);
  connectedGraph.addDoubleEdge(2, 0, true);

  testIsConnected(connectedGraph, "Connected Graph");

  Graph<bool> disconnectedGraph;
  disconnectedGraph.addDoubleEdge(0, 1, true);
  disconnectedGraph.addDoubleEdge(2, 3, true);

  testIsConnected(disconnectedGraph, "Disconnected Graph");

  return 0;
}