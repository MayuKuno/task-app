'use strict';
{
  const today = new Date();
  let year = today.getFullYear();
  let month = today.getMonth();

  function renderTitle(){
    const title = document.getElementById('title');
    title.textContent = `${year}/${String(month + 1).padStart(2, '0')}`
  }


  function getCalenderHead(){
    const dates = [];
    const lastDate = new Date(year, month, 0).getDate();
    const d = new Date(year, month, 1).getDay();
    for(let i = 0; i < d; i++){
      dates.unshift({
        date: lastDate - i,
        isdisabled: true,
        isToday: false,
      })
    }
    return dates;
  }

  function getCalendarBody(){
    const dates = [];
    const lastDate = new Date(year, month + 1, 0).getDate();
    for(let i = 1; i <= lastDate; i++){
      dates.push({
        date: i,
        isdisabled: false,
        isToday: false,
      });
    }
    
    if(year === today.getFullYear() && month === today.getMonth()){
      dates[today.getDate() - 1].isToday = true
    }
    return dates;
  }

  function getCalendarTail(){
    const dates = [];
    const d = new Date(year, month + 1, 0).getDay();
    for(let i = 1; i < 7 - d; i++){
      dates.push({
        date: i,
        isdisabled: true,
        isToday: false,
      });
    }
    return dates;

  }

  
  function renderWeeks(){
    const dates = [
      ...getCalenderHead(),
      ...getCalendarBody(),
      ...getCalendarTail(),
    ];

    const weeks = [];
    const weeksCount = dates.length / 7;
    
    for(let i = 0; i < weeksCount; i++){
      weeks.push(dates.splice(0, 7));
    }

    weeks.forEach(week => {
      const tr = document.createElement('tr');
      week.forEach(date =>{
        const td = document.createElement('td');
        const p = document.createElement('p');
        const span = document.createElement('span');
        p.textContent = date.date;
        td.appendChild(p);
        tr.appendChild(td);
        if(date.isdisabled){
          td.classList.add('disabled');
        }
        if(date.isToday){
          td.classList.add('today');
        }
        
        gon.tasks.forEach(task =>{
          const mon = String(month + 1).padStart(2, '0');
          if(year == task.deadline.slice(0,4) && mon == task.deadline.substr(5,2) && date.date == task.deadline.slice(-2) && date.isdisabled == false){
            
            span.textContent = task.taskname;
            td.appendChild(span);
          }
        })


        
      })
      document.getElementById('calendar').appendChild(tr);

    });


  }

  function clearCalendar(){
    const tbody = document.getElementById('calendar');
    while(tbody.firstChild){
      tbody.removeChild(tbody.firstChild)
    }
  }

  function createCalender(){
    clearCalendar();
    renderWeeks();
    renderTitle();
  }
  


document.addEventListener("DOMContentLoaded", function(){
  document.getElementById('prev').addEventListener('click', () => {
    month--;
    if(month < 0){ //もしmonthが1月だったら
      year--;
      month = 11;
    }
    createCalender();
  });
}, false);

document.addEventListener("DOMContentLoaded", function(){
  document.getElementById('next').addEventListener('click', () => {
    month++;
    if(month > 11){ //もしmonthが12月だったら
      year++;
      month = 0;
    }
    createCalender();
  });
}, false);

document.addEventListener("DOMContentLoaded", function(){
  document.getElementById('today').addEventListener('click', () => {
    year = today.getFullYear();
    month = today.getMonth();
    createCalender();
  });

}, false);
  
document.addEventListener("DOMContentLoaded", function(){
  createCalender();
}, false);

}