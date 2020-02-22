const autoComplete = require("@tarekraafat/autocomplete.js/dist/js/autoComplete");

document.onreadystatechange = function () {
  if (document.readyState == "interactive") {
    const selector = "#episode_name"
    const placeholder = "Episodes..."
    // The autoComplete.js Engine instance creator
    const autoCompletejs = new autoComplete({
      data: {
        src: async () => {
          // Loading placeholder text
          document
            .querySelector(selector)
            .setAttribute("placeholder", "Loading...");
          // Fetch External Data Source
          const source = await fetch(
            "/episodes.json"
          );

          const data = await source.json();
          // Post loading placeholder text
          document
            .querySelector(selector)
            .setAttribute("placeholder", placeholder);
          // Returns Fetched data
          return data;
        },
        key: ["title"],
        cache: false
      },
      sort: (a, b) => {
        if (a.match < b.match) return -1;
        if (a.match > b.match) return 1;
        return 0;
      },
      selector: selector,
      threshold: 0,
      debounce: 0,
      searchEngine: "strict",
      highlight: true,
      maxResults: 5,
      resultsList: {
        render: true,
        container: source => {
          source.setAttribute("id", "autoComplete_list");
        },
        destination: document.querySelector(selector),
        position: "afterend",
        element: "ul"
      },
      resultItem: {
        content: (data, source) => {
          source.innerHTML = data.match;
        },
        element: "li"
      },
      noResults: () => {
        const result = document.createElement("li");
        result.setAttribute("class", "no_result");
        result.setAttribute("tabindex", "1");
        result.innerHTML = "No Results";
        document.querySelector("#autoComplete_list").appendChild(result);
      },
      onSelection: feedback => {
        const selection = feedback.selection.value.title;
        // Render selected choice to selection div
        document.querySelector(".selection").innerHTML = selection;
        // Clear Input
        document.querySelector(selector).value = "";
        // Change placeholder with the selected value
        document
          .querySelector(selector)
          .setAttribute("placeholder", selection);
        // Concole log autoComplete data feedback

        document.getElementById("segment_episode_id").value = feedback.selection.value.id
      }
    });
  }
}