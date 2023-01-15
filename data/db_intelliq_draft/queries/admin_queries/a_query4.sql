				  
4

DELETE answer  from answer , session 
where ['input'] = session.questionnaireID 
      and session.session = answer.session
	  
	  
DELETE  from  session 
where ['input'] = session.questionnaireID 

