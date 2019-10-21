/*
 * Copyright (c) 2019, Ford Motor Company
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

#include "app_service_rpc_plugin/app_service_rpc_plugin.h"
#include <memory>
#include "app_service_rpc_plugin/app_service_app_extension.h"
#include "application_manager/mock_application.h"
#include "gtest/gtest.h"

namespace {
const std::string kAppServiceType1 = "AppServiceType1";
const std::string kAppServiceType2 = "AppServiceType2";
}  // namespace

namespace app_service_plugin_test {

using test::components::application_manager_test::MockApplication;
using ::testing::_;
using ::testing::Mock;
using ::testing::NiceMock;
using ::testing::Return;
using ::testing::ReturnNull;
using ::testing::ReturnRef;
using ::testing::SaveArg;

using namespace app_service_rpc_plugin;
namespace strings = application_manager::strings;
namespace plugins = application_manager::plugin_manager;

class AppServiceRPCPluginTest : public ::testing::Test {
 public:
  AppServiceRPCPluginTest()
      : mock_app_(std::make_shared<NiceMock<MockApplication> >()) {
    ON_CALL(*mock_app_, AddExtension(_)).WillByDefault(Return(true));
  }

  void SubscribeAppServices(
      std::shared_ptr<AppServiceAppExtension> app_service_app_extension) {
    if (app_service_app_extension.get()) {
      ASSERT_TRUE(
          app_service_app_extension->SubscribeToAppService(kAppServiceType1));
      ASSERT_TRUE(app_service_app_extension->IsSubscribedToAppService(
          kAppServiceType1));
      ASSERT_TRUE(
          app_service_app_extension->SubscribeToAppService(kAppServiceType2));
      ASSERT_TRUE(app_service_app_extension->IsSubscribedToAppService(
          kAppServiceType2));
    }
  }

 protected:
  app_service_rpc_plugin::AppServiceRpcPlugin app_service_plugin_;
  std::shared_ptr<MockApplication> mock_app_;
};

TEST_F(AppServiceRPCPluginTest, OnApplicationEvent_ApplicationRegistered) {
  auto event = plugins::ApplicationEvent::kApplicationRegistered;
  EXPECT_CALL(*mock_app_, AddExtension(_));
  app_service_plugin_.OnApplicationEvent(event, mock_app_);
}

TEST_F(AppServiceRPCPluginTest, OnApplicationEvent_ApplicationUnregistered) {
  auto app_service_app_extension =
      std::make_shared<AppServiceAppExtension>(app_service_plugin_, *mock_app_);
  SubscribeAppServices(app_service_app_extension);

  ON_CALL(*mock_app_, QueryInterface(_))
      .WillByDefault(Return(app_service_app_extension));
  EXPECT_CALL(*mock_app_, AddExtension(_)).Times(0);
  EXPECT_CALL(*mock_app_, QueryInterface(_));

  const auto event = plugins::ApplicationEvent::kDeleteApplicationData;
  app_service_plugin_.OnApplicationEvent(event, mock_app_);

  EXPECT_FALSE(
      app_service_app_extension->IsSubscribedToAppService(kAppServiceType1));
  EXPECT_FALSE(
      app_service_app_extension->IsSubscribedToAppService(kAppServiceType2));
}

}  // namespace app_service_plugin_test
