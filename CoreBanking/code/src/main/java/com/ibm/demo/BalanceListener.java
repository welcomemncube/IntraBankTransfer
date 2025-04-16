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
import javax.jms.ConnectionFactory;
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
import javax.jms.JMSConnectionFactory;
import javax.jms.JMSContext;
import javax.jms.Queue;
import javax.jms.ConnectionFactory;

 @MessageDriven(name = "BalanceMDB")
 public class BalanceListener implements MessageListener {

   private static String selectString1="select * from account WHERE(id=1)";

   public void onMessage(Message message) {
     try {
       String msgBody = new String(message.getBody(byte[].class));
       System.out.println("MDB received: " + msgBody);

       DataSource coreDB = InitialContext.doLookup("jdbc/coreDB");

       Connection coreConn = coreDB.getConnection();
       Statement stmt = coreConn.createStatement();
       String selectString = selectString1;
       System.out.println("selectString="+selectString);
       ResultSet rs = stmt.executeQuery(selectString);
       rs.next();
       String balance = rs.getString("amount");
       Queue outQueue = (Queue)InitialContext.doLookup("jms/balanceout");
       JMSContext context = ((ConnectionFactory)InitialContext.doLookup("jms/ibmmqCF")).createContext();
       context.createProducer().send(outQueue, balance);
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
