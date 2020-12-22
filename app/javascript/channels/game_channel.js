import consumer from "./consumer";

const initGameCable = () => {
  const playersList = document.getElementById('players-list');
  if (playersList) {
    const id = playersList.dataset.gameId;

    consumer.subscriptions.create({ channel: "GameChannel", id: id }, {
      received(data) { // called when data is broadcast in the cable
        switch (data.action) {
          case "add player":
            playersList.insertAdjacentHTML('beforeend', data.content);
            break;
          case "start":
            window.location.pathname = `/questions/${data.id}`;
            break;
        }
      },
    });
  }

  const answersList = document.getElementById('answers-list');
  if (answersList) {
    const id = answersList.dataset.gameId;
    consumer.subscriptions.create({ channel: "GameChannel", id: id }, {
      received(data) { // called when data is broadcast in the cable
        switch (data.action) {
          case "show answers":
            location.reload();
            break;
        }
      },
    });
  }

  const votesList = document.getElementById('votes-list');
  if (votesList) {
    const id = votesList.dataset.gameId;
    consumer.subscriptions.create({ channel: "GameChannel", id: id }, {
      received(data) { // called when data is broadcast in the cable
        switch (data.action) {
          case "show votes":
            location.reload();
            break;
        }
      },
    });
  }
}

export { initGameCable };
