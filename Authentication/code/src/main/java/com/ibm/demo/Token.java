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

public class Token
{
    String token;

    public String getToken()
    {
       return token;
    }

    public void setToken(String iToken)
    {
       token=iToken;
    }

    public Token(Credentials credentials)
    {
       token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkNhbGx1bSBKYWNrc29uIiwiaWF0IjoxNTE2MjM5MDIyfQ.uAm8twDkd6zQUN_Hw-vP4yPA-zyAHizjCLmcWpM9Qxc";
    }

}
