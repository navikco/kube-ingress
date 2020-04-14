package net.kube.land.accounts.controller;

import net.kube.land.accounts.AccountsApplication;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.restdocs.JUnitRestDocumentation;
import org.springframework.restdocs.mockmvc.RestDocumentationResultHandler;
import org.springframework.restdocs.payload.JsonFieldType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import static org.springframework.restdocs.mockmvc.MockMvcRestDocumentation.document;
import static org.springframework.restdocs.mockmvc.MockMvcRestDocumentation.documentationConfiguration;
import static org.springframework.restdocs.operation.preprocess.Preprocessors.*;
import static org.springframework.restdocs.payload.PayloadDocumentation.fieldWithPath;
import static org.springframework.restdocs.payload.PayloadDocumentation.responseFields;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = AccountsApplication.class)
@WebAppConfiguration
@ActiveProfiles("local")
public class AccountControllerTest {
    @Rule
    public JUnitRestDocumentation restDocumentation = new JUnitRestDocumentation("build/generated-snippets");

    @Autowired
    private WebApplicationContext context;

    private MockMvc mockMvc;

    private RestDocumentationResultHandler document;

    @Before
    public void setUp() {

        this.document = document("{method-name}", preprocessRequest(prettyPrint()), preprocessResponse(prettyPrint()));

        this.mockMvc = MockMvcBuilders.webAppContextSetup(this.context)
                .apply(documentationConfiguration(this.restDocumentation))
                .alwaysDo(this.document)
                .build();
    }

    @Test
    public void list() throws Exception {
        this.mockMvc.perform(get("/kube/accounts").accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andDo(document("list-accounts", preprocessRequest(prettyPrint()),
                        preprocessResponse(prettyPrint()), responseFields(
                                fieldWithPath("[].accountId").type(JsonFieldType.STRING).optional().description("Account Id"),
                                fieldWithPath("[].accountName").type(JsonFieldType.STRING).optional().description("Account Name"),
                                fieldWithPath("[].accountStatus").type(JsonFieldType.STRING).optional().description("Account Status"),
                                fieldWithPath("[].accountType").type(JsonFieldType.STRING).optional().description("Account Type")
                        )
                )
        );
    }

    @Test
    public void getAccount() throws Exception {
        this.mockMvc.perform(get("/kube/accounts/300").accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andDo(document("get-account", preprocessRequest(prettyPrint()),
                        preprocessResponse(prettyPrint()), responseFields(
                                fieldWithPath("accountId").type(JsonFieldType.STRING).optional().description("Account Id"),
                                fieldWithPath("accountName").type(JsonFieldType.STRING).optional().description("Account Name"),
                                fieldWithPath("accountStatus").type(JsonFieldType.STRING).optional().description("Account Status"),
                                fieldWithPath("accountType").type(JsonFieldType.STRING).optional().description("Account Type")
                        )
                )
        );
    }
}

