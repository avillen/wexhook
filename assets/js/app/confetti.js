function shootConfetti() {
  const colors = ["#00bcd2", "#e0105e", "#fcf801"]

  confetti({
    particleCount: 100,
    angle: 60,
    spread: 55,
    origin: { x: 0 },
    colors
  })

  confetti({
    particleCount: 100,
    angle: 120,
    spread: 55,
    origin: { x: 1 },
    colors
  })
};

export default shootConfetti
