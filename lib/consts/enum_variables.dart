//* news type
enum NewsType {
  topTrending,
  allNews,
}

// * for dropdown for sorting news
enum SortByNews {
  relevancy, //* articles more closely related to q come first.
  popularity, //* articles from popular sources and publishers come first.
  publishedAt, //* newest articles come first.
}


//* search query keywords
const List<String> searchKeyword = [
  "Football",
  "Flutter",
  "Python",
  "Weather",
  "Crypto",
  "Bitcoin",
  "Youtube",
  "Netflix",
  "Meta"
];
