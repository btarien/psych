import consumer from "./consumer";

const initGameCable = () => {
  const playersList = document.getElementById('players-list');
  if (playersList) {
    const id = playersList.dataset.gameId;

    consumer.subscriptions.create({ channel: "GameChannel", id: id }, {
      received(data) { // called when data is broadcast in the cable
        switch (data.action) {
          case "start":
            window.location.pathname = `/questions/${data.id}`;
            break;
          case "add player":
            playersList.insertAdjacentHTML('beforeend', data.content);
            break;
        }
      },
    });
  }
}

export { initGameCable };
