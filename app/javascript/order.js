function order (){
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);

  const orderButton = document.getElementById("button");
  orderButton.addEventListener("click", (e) => {
    // console.log(document.getElementById("charge-form"));

    e.preventDefault();

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("order_address[number]"),
      cvc: formData.get("order_address[cvc]"),
      exp_month: formData.get("order_address[exp_month]"),
      exp_year: `20${formData.get("order_address[exp_year]")}`,
    };
    
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);

        document.getElementById("card-number").removeAttribute("name");
        document.getElementById("card-cvc").removeAttribute("name");
        document.getElementById("card-exp-month").removeAttribute("name");
        document.getElementById("card-exp-year").removeAttribute("name");

        document.getElementById("charge-form").submit();

      }
    });


  // const cardNumber = document.getElementById("card-number");
  // const cardExpMonth = document.getElementById("card-exp-month");
  // const cardExpYear = document.getElementById("card-exp-year");
  // const cardCvc = document.getElementById("card-cvc");
  // const cardData = new FormData(cardNumber);
  // const XHR = new XMLHttpRequest();
  // XHR.open("POST", "/items/#{item.id}/orders", true);
  // XHR.responseType = "json";
  // XHR.send(formData);
  // console.log(cardData)

// };

     //      const taxPrice = document.getElementById("add-tax-price");
//      taxPrice.innerHTML = Math.floor(inputPrice * 0.1);
//       const profit  = document.getElementById("profit");
//       profit.innerHTML = inputPrice - taxPrice.innerHTML;

 });

};

window.addEventListener('load', order);

