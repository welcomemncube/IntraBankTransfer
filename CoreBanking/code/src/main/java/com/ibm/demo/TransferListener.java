/*******************************************************************************
 * Copyright (c) 2022 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     IBM Corporation - Initial implementation
 *******************************************************************************/
 package com.ibm.demo;

 import javax.ejb.MessageDriven;
 import javax.jms.JMSException;
 import javax.jms.Message;
 import javax.jms.MessageListener;
 import javax.annotation.Resource;
 import javax.sql.DataSource;
 import javax.naming.InitialContext;
 import javax.naming.NamingException;
 import java.sql.Connection;
 import java.sql.Statement;
 import java.sql.ResultSet;
 import java.sql.SQLException;
 import java.time.format.DateTimeFormatter;
 import java.time.LocalDateTime;

 @MessageDriven(name = "TransferMDB")
 public class TransferListener implements MessageListener {

   private static String updateString1="update account SET id=1,timestamp=";
   private static String updateString2=",amount=";

   public void onMessage(Message message) {
     try {
       String msgBody = new String(message.getBody(byte[].class));
       System.out.println("MDB received: " + msgBody);

       DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
       LocalDateTime now = LocalDateTime.now();

       DataSource coreDB = InitialContext.doLookup("jdbc/coreDB");

       Connection coreConn = coreDB.getConnection();
       Statement stmt = coreConn.createStatement();
       String updateString = updateString1+"'"+dtf.format(now)+"'"+updateString2+"'"+msgBody+"'";
       System.out.println("updateString="+updateString);
       int rc = stmt.executeUpdate(updateString);
       System.out.println("Return Code="+rc);

     } catch (JMSException e) {
       throw new RuntimeException(e);
     }
     catch (SQLException e) {
         e.printStackTrace();
     }
     catch (NamingException e) {
         e.printStackTrace();
     }
   }
 }
