function answer (){
  const answerBtn = document.getElementById("answer-choice")
  const firstBtn = document.getElementById("first-incorrection-choice")
  const secondBtn = document.getElementById("second-incorrection-choice")

  answerBtn.addEventListener("click", () => {
    const firstBtn = document.getElementById("first-incorrection-choice")
    const secondBtn = document.getElementById("second-incorrection-choice")  
    firstBtn.setAttribute("disabled","")
    firstBtn.setAttribute("style","background: gray;")
    secondBtn.setAttribute("disabled","")
    secondBtn.setAttribute("style","background: gray;")
  });

  firstBtn.addEventListener("click", () => {
    const answerBtn = document.getElementById("answer-choice")
    const secondBtn = document.getElementById("second-incorrection-choice")  
    answerBtn.setAttribute("disabled","")
    answerBtn.setAttribute("style","background: gray;")
    secondBtn.setAttribute("disabled","")
    secondBtn.setAttribute("style","background: gray;")
  });

  secondBtn.addEventListener("click", () => {
    const answerBtn = document.getElementById("answer-choice")
    const firstBtn = document.getElementById("first-incorrection-choice")  
    answerBtn.setAttribute("disabled","")
    answerBtn.setAttribute("style","background: gray;")
    firstBtn.setAttribute("disabled","")
    firstBtn.setAttribute("style","background: gray;")
  });
};
 
window.addEventListener('load', answer);