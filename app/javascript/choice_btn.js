function answer (){
  const answerBtn = document.getElementById("answer-choice")
  const firstBtn = document.getElementById("first-incorrection-choice")
  const secondBtn = document.getElementById("second-incorrection-choice")

  answerBtn.addEventListener("click", () => {
    answerBtn.setAttribute("style","background: orange;")
    firstBtn.setAttribute("disabled","")
    firstBtn.setAttribute("style","background: gray;")
    secondBtn.setAttribute("disabled","")
    secondBtn.setAttribute("style","background: gray;")
  });

  firstBtn.addEventListener("click", () => {
    answerBtn.setAttribute("disabled","")
    answerBtn.setAttribute("style","background: darkorange;")
    firstBtn.setAttribute("style","background: darkblue;")
    secondBtn.setAttribute("disabled","")
    secondBtn.setAttribute("style","background: gray;")
  });

  secondBtn.addEventListener("click", () => {
    answerBtn.setAttribute("disabled","")
    answerBtn.setAttribute("style","background: darkorange;")
    firstBtn.setAttribute("disabled","")
    firstBtn.setAttribute("style","background: gray;")
    secondBtn.setAttribute("style","background: darkblue;")
  });
};
 
window.addEventListener('load', answer);