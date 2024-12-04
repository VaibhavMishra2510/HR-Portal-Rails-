document.addEventListener("turbo:load", function () {
  const returnButtons = document.querySelectorAll(".return-btn");

  returnButtons.forEach((button) => {
    button.addEventListener("click", function (e) {
      setTimeout(() => {
        const row = e.target.closest("tr");

        if (row) {
          row.querySelector(".assigned-to").textContent = "N/A";
          row.querySelector(".assigned-date").textContent = "N/A";
          row.querySelector(".return-date").textContent = "N/A";
        }
      }, 2000); 
    });
  });
});
