import consumer from "./consumer";

const initGameCable = () => {
  const playersList = document.getElementById('players-list');
  if (playersList) {
    const id = playersList.dataset.gameId;

    consumer.subscriptions.create({ channel: "GameChannel", id: id }, {
      received(data) { // called when data is broadcast in the cable
        playersList.insertAdjacentHTML('beforeend', data);
      },
    });
  }
}

export { initGameCable };
