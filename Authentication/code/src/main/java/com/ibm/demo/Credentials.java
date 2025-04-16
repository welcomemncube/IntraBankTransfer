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

public class Credentials
{
    String username;
    String password;

    public String getUsername()
    {
       return username;
    }

    public String getPassword()
    {
       return password;
    }

    public void setUsername(String iUsername)
    {
       username=iUsername;
    }

    public void setPassword(String iPassword)
    {
       password=iPassword;
    }

    public Credentials()
    {
       username="";
       password="";
    }

}
