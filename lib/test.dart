void main() {
  List mm = [1, 2, 3, 4, 6, 8, 9, 1];
  List result = [];
  for (int i = 0; i < mm.length - 1; i++) {
    result.add(mm[i] + mm[i + 1]);
  }
  print(result);
}
