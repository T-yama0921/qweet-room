function answer (){
  const answerChoice = document.getElementById("answer-choice");
  const firstIncorrectionChoice = document.getElementById("first-incorrection-choice");
  const secondIncorrectionChoice = document.getElementById("second-incorrection-choice");

  answerChoice.addEventListener("click", () => {
    const answerFeedback = document.getElementById("answer-feedback")
    answerFeedback.setAttribute("style","display: block;")
  });
  firstIncorrectionChoice.addEventListener("click", () => {
    const firstFeedback = document.getElementById("first-feedback")
    firstFeedback.setAttribute("style","display: block;")
  });
  secondIncorrectionChoice.addEventListener("click", () => {
    const secondFeedback = document.getElementById("second-feedback")
    secondFeedback.setAttribute("style","display: block;")
  });
 };
 
window.addEventListener('load', answer);
