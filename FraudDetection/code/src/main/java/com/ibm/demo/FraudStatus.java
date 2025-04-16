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

public class FraudStatus
{
    String status;

    public String getStatus()
    {
       return status;
    }

    public void setStatus(String iStatus)
    {
       status=iStatus;
    }

    public FraudStatus(FraudCheck check)
    {
       status="ALLOW";
    }

}
