function tax (){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("input", () => {
     const inputPrice = itemPrice.value;
     const taxPrice = document.getElementById("add-tax-price");
     taxPrice.innerHTML = Math.floor(inputPrice * 0.1);
      const profit  = document.getElementById("profit");
      profit.innerHTML = inputPrice - taxPrice.innerHTML;

 });

};

window.addEventListener('load', tax);

