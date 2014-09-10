/*
 * Copyright (c) 2014, Ford Motor Company
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following
 * disclaimer in the documentation and/or other materials provided with the
 * distribution.
 *
 * Neither the name of the Ford Motor Company nor the names of its contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#include "transport_manager/aoa/aoa_dynamic_device.h"

#include "utils/logger.h"

#include "transport_manager/aoa/aoa_wrapper.h"
#include "transport_manager/transport_adapter/transport_adapter_controller.h"

namespace transport_manager {
namespace transport_adapter {

CREATE_LOGGERPTR_GLOBAL(logger_, "TransportManager")

const std::string AOADynamicDevice::kPathToConfig = "";  // default on QNX /etc/mm/aoa.conf

AOADynamicDevice::AOADynamicDevice(const std::string& name,
                                   const DeviceUID& unique_id,
                                   const AOAWrapper::AOAUsbInfo& info,
                                   TransportAdapterController* controller)
    : AOADevice(name, unique_id),
      life_(new LifeDevice(this)),
      controller_(controller),
      aoa_usb_info_(info) {
}

AOADynamicDevice::~AOADynamicDevice() {
  AOAWrapper::Shutdown();
  delete life_;
  life_ = NULL;
}

bool AOADynamicDevice::Init() {
  if (kPathToConfig.empty()) {
    return AOAWrapper::Init(aoa_usb_info_, life_);
  } else {
    return AOAWrapper::Init(kPathToConfig, aoa_usb_info_, life_);
  }
}

void AOADynamicDevice::Notify() {
  LOG4CXX_TRACE(logger_, "AOA: notify about all connected devices");
  DeviceVector devices;
  for (DeviceContainer::const_iterator i = devices_.begin();
      i != devices_.end(); ++i) {
    AOADevicePtr aoa_device = i->second;
    DeviceSptr device = AOADevicePtr::static_pointer_cast<Device>(aoa_device);
    devices.push_back(device);
  }
  controller_->SearchDeviceDone(devices);
}

void AOADynamicDevice::AddDevice(AOAWrapper::AOAHandle hdl) {
  LOG4CXX_TRACE(logger_, "AOA: add new device " << hdl);
  set_handle(hdl);
  sync_primitives::AutoLock locker(devices_lock_);
  devices_.insert(std::make_pair(hdl, this));
  Notify();
}

void AOADynamicDevice::RemoveDevice(AOAWrapper::AOAHandle hdl) {
  LOG4CXX_TRACE(logger_, "AOA: remove device " << hdl);
  sync_primitives::AutoLock locker(devices_lock_);
  devices_.erase(hdl);
  Notify();
}

void AOADynamicDevice::LoopDevice(AOAWrapper::AOAHandle hdl) {
  LOG4CXX_TRACE(logger_, "AOA: loop of life device " << hdl);
  sync_primitives::AutoLock locker(life_lock_);
  while (AOAWrapper::IsHandleValid(hdl)) {
    LOG4CXX_TRACE(logger_, "AOA: wait cond " << hdl);
    life_cond_.Wait(locker);
  }
}

void AOADynamicDevice::StopDevice(AOAWrapper::AOAHandle hdl) {
  LOG4CXX_TRACE(logger_, "AOA: stop device " << hdl);
  life_cond_.Broadcast();
}

AOADynamicDevice::LifeDevice::LifeDevice(AOADynamicDevice* parent)
    : parent_(parent) {
}

void AOADynamicDevice::LifeDevice::Loop(AOAWrapper::AOAHandle hdl) {
  parent_->AddDevice(hdl);
  parent_->LoopDevice(hdl);
  parent_->RemoveDevice(hdl);
}

void AOADynamicDevice::LifeDevice::Died(AOAWrapper::AOAHandle hdl) {
  parent_->StopDevice(hdl);
}

}  // namespace transport_adapter
}  // namespace transport_manager
