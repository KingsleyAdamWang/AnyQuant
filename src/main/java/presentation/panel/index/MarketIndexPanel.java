package presentation.panel.index;

import bl.ShowIndexData;
import config.IndexDataConfig;
import config.SystemConfig;
import data.GetIndexData;
import org.dom4j.DocumentException;
import presentation.UltraSwing.UltraButton;
import presentation.UltraSwing.UltraPanel;
import presentation.UltraSwing.UltraScrollPane;
import presentation.frame.MainFrame;
import presentation.panel.info.AnalyzePanel;
import presentation.panel.operation.OperationPanel;
import presentation.util.DateChooser;
import presentation.util.Table;
import vo.IndexVO;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.IOException;
import java.net.MalformedURLException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 * Created by 宋益明 on 16-3-28.
 * <p>
 * 大盘指数面板
 * 用于展示大盘指数的信息
 */
public class MarketIndexPanel extends OperationPanel implements ItemListener {

    /**
     * 大盘指数值对象
     */
    private IndexVO index;

    /**
     * 北部面板，承载日期选择框
     */
    private UltraPanel northPanel;

    /**
     * 日期选择框
     */
    private DateChooser dcStart, dcEnd;
    /**
     * 开始、结束日期
     */
    String startTime,endTime;
    /**
     * 生成按钮
     */
    private JButton confirm;

    /**
     * 表格选项面板
     */
    private UltraPanel columnsPanel;

    /**
     * 复选框，对应表格中显示的列
     * "最高", "最低", "开盘价", "收盘价", "成交量", "后复权价"
     */
    private JCheckBox high, low, open, close, volume, adjPrice;

    /**
     * 表格的列名，包含日期及上述复选框中选择显示的列
     */
    private List<Integer> columnSelect;

    /**
     * 所有数据
     */
    private Object[][] allData;

    /**
     * 所有列
     */
    private String[] allColumns;

    /**
     * 需要显示的数据
     */
    private Object[][] data;

    /**
     * 需要显示的列
     */
    private String[] columns;

    /**
     * 表格对象
     */
    private Table table;

    /**
     * K线图、折线图、综合分析
     * TODO BUTTON
     */
    private JButton labelK_Line, labelBrokenLien, labelAnalyze;

    /**
     * 配置对象
     */
    private IndexDataConfig config;

    public MarketIndexPanel() {
        init();
        createUIComponents();
        initColumns();
        addListeners();
    }

    protected void init() {
        setLayout(null);

        try {
            index = new ShowIndexData().getLatestIndexData();
        } catch (IOException e) {
            e.printStackTrace();
        }

        table = initTable();
        update();
    }

    /**
     * 初始化表格数据
     */
    private Table initTable() {
        allData = new Object[index.getDate().length][];
        startTime=index.getDate()[0];
        endTime=index.getDate()[index.getDate().length-1];
        allColumns = new String[]{
                "日期", "最高", "最低", "开盘价", "收盘价", "成交量", "后复权价"};

        for (int i = 0; i < index.getDate().length; i++) {
            allData[i] = new Object[]{
                    index.getDate()[i],
                    index.getHigh()[i],
                    index.getLow()[i],
                    index.getOpen()[i],
                    index.getClose()[i],
                    index.getVolume()[i] / 1000 + "万",
                    index.getAdj_price()[i],
            };
        }

        return new Table(allData, allColumns);
    }

    /**
     * 创建组件
     */
    protected void createUIComponents() {
        createNorthPanel();
        createCenterPanel();
        createSouthPanel();
    }

    /**
     * 创建北部面板，包含日期选择框
     */
    private void createNorthPanel() {
        northPanel = new UltraPanel();
        northPanel.setLayout(null);

        dcStart = new DateChooser(northPanel,
                PANEL_WIDTH - MARGIN - BUTTON_WIDTH - PADDING * 6 - BUTTON_HEIGHT * 2,
                MARGIN, BUTTON_WIDTH + PADDING, BUTTON_HEIGHT);
        dcEnd = new DateChooser(northPanel,
                PANEL_WIDTH - MARGIN - BUTTON_WIDTH - PADDING * 3 - BUTTON_HEIGHT,
                MARGIN, BUTTON_WIDTH + PADDING, BUTTON_HEIGHT);
        confirm = new UltraButton("生成");
        dcEnd.setTime(endTime);
        dcStart.setTime(startTime);
        northPanel.add(confirm);


        add(northPanel);
    }

    /**
     * 创建中心面板，包含当前信息
     */
    private void createCenterPanel() {
//        centerPanel = new UltraPanel();
//        centerPanel.setLayout(new BorderLayout());
//        centerPanel.setPreferredSize(new Dimension(PANEL_WIDTH,
//                PANEL_HEIGHT - BUTTON_HEIGHT * 2 - MARGIN * 2));
        {
            columnsPanel = new UltraPanel();
            columnsPanel.setLayout(new FlowLayout(FlowLayout.LEFT));
            columnsPanel.setPreferredSize(new Dimension(PANEL_WIDTH - MARGIN * 2,
                    BUTTON_HEIGHT));

            high = new JCheckBox("最高价");
            low = new JCheckBox("最低价");
            open = new JCheckBox("开盘价");
            close = new JCheckBox("收盘价");
            volume = new JCheckBox("成交量");
            adjPrice = new JCheckBox("后复权价");

            columnsPanel.add(high);
            columnsPanel.add(low);
            columnsPanel.add(open);
            columnsPanel.add(close);
            columnsPanel.add(volume);
            columnsPanel.add(adjPrice);

//            columnsPanel.setPreferredSize(new Dimension(700, 100));
//            centerPanel.add(columnsPanel, BorderLayout.NORTH);
            add(columnsPanel);
        }

        {
//            UltraPanel southPanel = new UltraPanel();
//            southPanel.setLayout(new FlowLayout(FlowLayout.CENTER));
//            southPanel.setPreferredSize(new Dimension(PANEL_WIDTH - MARGIN * 2,
//                    centerPanel.getPreferredSize().height - BUTTON_HEIGHT));
            initColumns();
            table = createSelectTable();
            scrollPane = new UltraScrollPane(table);
//            scrollPane.setPreferredSize(new Dimension(700, 400));
//            southPanel.add(scrollPane);

//            centerPanel.setPreferredSize(new Dimension(700, 500));
//            centerPanel.add(scrollPane, BorderLayout.SOUTH);
//            centerPanel.add(southPanel, BorderLayout.SOUTH);
        }

//        centerPanel.setBounds(0, BUTTON_HEIGHT + MARGIN,
//                PANEL_WIDTH, PANEL_HEIGHT - BUTTON_HEIGHT * 2 - MARGIN * 2);
//        add(centerPanel);
        add(scrollPane);
    }

    /**
     * 创建南部面板，包含图表
     */
    private void createSouthPanel() {
//        southPanel = new UltraPanel();
//        southPanel.setLayout(new FlowLayout(FlowLayout.LEFT));
//        southPanel.setPreferredSize(new Dimension(PANEL_WIDTH, BUTTON_HEIGHT + MARGIN));

        labelK_Line = new UltraButton(1);
        labelBrokenLien = new UltraButton(2);
        labelAnalyze = new UltraButton(3);
        labelK_Line.setSize(BUTTON_WIDTH,BUTTON_WIDTH);
        labelBrokenLien.setSize(BUTTON_WIDTH,BUTTON_WIDTH);
        labelAnalyze.setSize(BUTTON_WIDTH,BUTTON_WIDTH);

//        southPanel.setPreferredSize(
//                new Dimension(MainFrame.getMainFrame().getWidth(), BUTTON_HEIGHT + MARGIN * 2));

//        southPanel.add(labelK_Line);
//        southPanel.add(labelBrokenLien);
//        southPanel.add(labelAnalyze);

//        southPanel.setBounds(0, PANEL_HEIGHT - BUTTON_HEIGHT - MARGIN,
//                PANEL_WIDTH, BUTTON_HEIGHT + MARGIN);
//        add(southPanel);
        add(labelAnalyze);
        add(labelK_Line);
        add(labelBrokenLien);
    }

    /**
     * 创建并返回表格面板，包含表格选项（所有复选框）、表格
     *
     * @return 表格面板
     */
    private UltraPanel createTablePanel() {
        UltraPanel tablePanel = new UltraPanel();
        tablePanel.setLayout(null);

        {//复选框面板，包含所有复选框
            UltraPanel columnsPanel = new UltraPanel();
            columnsPanel.setLayout(new FlowLayout(FlowLayout.LEFT));

            high = new JCheckBox("最高价");
            low = new JCheckBox("最低价");
            open = new JCheckBox("开盘价");
            close = new JCheckBox("收盘价");
            volume = new JCheckBox("成交量");
            adjPrice = new JCheckBox("后复权价");

            columnsPanel.add(high);
            columnsPanel.add(low);
            columnsPanel.add(open);
            columnsPanel.add(close);
            columnsPanel.add(volume);
            columnsPanel.add(adjPrice);

            columnsPanel.setBounds(0, 0, PANEL_WIDTH - MARGIN * 3 - BUTTON_WIDTH, BUTTON_HEIGHT);
            tablePanel.add(columnsPanel);
        }

        {
            scrollPane = new UltraScrollPane(table);
            scrollPane.setBounds(0, BUTTON_HEIGHT, PANEL_HEIGHT,
                    table.getColumnModel().getTotalColumnWidth());
            tablePanel.add(scrollPane);
        }

        return tablePanel;
    }

    /**
     * 创建并返回选项面板，包含“K线图“、”折线图“、”综合分析“
     *
     * @return 选项面板
     */
    private UltraPanel createOptionsPanel() {
        UltraPanel optionsPanel = new UltraPanel();
//        optionsPanel.setLayout(null);
        Box box = Box.createVerticalBox();


        labelK_Line = new UltraButton(1);
        labelBrokenLien = new UltraButton(2);
        labelAnalyze = new UltraButton(3);
        labelK_Line.setSize(BUTTON_WIDTH,BUTTON_WIDTH);
        labelBrokenLien.setSize(BUTTON_WIDTH,BUTTON_WIDTH);
        labelAnalyze.setSize(BUTTON_WIDTH,BUTTON_WIDTH);


        box.add(labelK_Line);
        box.add(labelBrokenLien);
        box.add(labelAnalyze);

        optionsPanel.add(box);
//        optionsPanel.add(labelK_Line);
//        optionsPanel.add(labelBrokenLien);
//        optionsPanel.add(labelAnalyze);

        return optionsPanel;
    }

    /**
     * 添加事件监听器
     */
    private void addListeners() {
        addComponentListener(new ComponentAdapter() {
            @Override
            public void componentResized(ComponentEvent e) {
                assignment();
            }

            @Override
            public void componentHidden(ComponentEvent e) {
                assignment();
            }
        });

        confirm.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                try {
                    String start = dcStart.getTime();
                    String startDate = start.substring(0, 4) + "-" + start.substring(4, 6) + "-" + start.substring(6, 8);
                    String end = dcEnd.getTime();
                    String endDate = end.substring(0, 4) + "-" + end.substring(4, 6) + "-" + end.substring(6, 8);
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
                    Calendar c = Calendar.getInstance();
                    c.add(Calendar.DATE, -1);
                    String eDate= df.format(c.getTime()).substring(0, 10);//结束日期

                    System.out.println(eDate);
                    int compareSE=startDate.compareTo(eDate);
                    System.out.println(startDate+"startDate");
                    System.out.println(endDate+"endDate");

                    int compareEE=endDate.compareTo(eDate);
                    System.out.println(compareEE);
                    int valid=startDate.compareTo(endDate);
                    if(valid>=0 || (compareSE>0&&compareEE>0)){
                        System.out.println("aaaaaa");
                        JOptionPane.showMessageDialog(MainFrame.getMainFrame(), "输入日期不合法！");
                    }

                    index = new IndexVO(new GetIndexData().getIndexDataBetween(
                                    dcStart.getTime(), dcEnd.getTime()));

                    initTable();
                    scrollPane.getViewport().remove(table);
                    table = createSelectTable();
                    scrollPane.getViewport().add(table);

                    assignment();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
        });

        labelK_Line.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                MainFrame.getMainFrame().addOperationPanel(
                        new IndexKLinePanel(MarketIndexPanel.this));
            }
        });

        labelBrokenLien.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                MainFrame.getMainFrame().addOperationPanel(
                        new IndexBrokenLinePanel(MarketIndexPanel.this));
            }
        });

        labelAnalyze.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                try {
                    MainFrame.getMainFrame().addOperationPanel(
                            new AnalyzePanel(MarketIndexPanel.this, index));
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }
        });
    }

    /**
     * 界面大小发生变化时，对组件位置重新赋值
     */
    private void assignment() {
        confirm.setBounds(PANEL_WIDTH - MARGIN - BUTTON_WIDTH, MARGIN,
                BUTTON_WIDTH, BUTTON_HEIGHT);
        northPanel.setBounds(0, 0, PANEL_WIDTH, BUTTON_HEIGHT + MARGIN);
        columnsPanel.setBounds(MARGIN, BUTTON_HEIGHT + MARGIN * 2,
                PANEL_WIDTH - MARGIN * 2, BUTTON_HEIGHT);
        scrollPane.setBounds(MARGIN, columnsPanel.getY() + columnsPanel.getHeight(),
                table.getColumnModel().getTotalColumnWidth() + 20,
                PANEL_HEIGHT - (columnsPanel.getY() + columnsPanel.getHeight()) - PADDING);
        labelK_Line.setBounds(PANEL_WIDTH - PADDING - 2*BUTTON_WIDTH, scrollPane.getY(),
                BUTTON_WIDTH,BUTTON_WIDTH);
        labelBrokenLien.setBounds(labelK_Line.getX(), labelK_Line.getY() + BUTTON_WIDTH+ PADDING,
                BUTTON_WIDTH, BUTTON_WIDTH);
        labelAnalyze.setBounds(labelK_Line.getX(), labelBrokenLien.getY() + BUTTON_WIDTH + PADDING,
                BUTTON_WIDTH, BUTTON_WIDTH);

        revalidate();
        repaint();
    }

    /**
     * 初始化列名
     */
    private void initColumns() {
        try {
            config = SystemConfig.getIndexDataConfig();
        } catch (MalformedURLException | DocumentException e) {
            e.printStackTrace();
        }

        high.setSelected(config.isHighSelected());
        low.setSelected(config.isLowSelected());
        open.setSelected(config.isOpenSelected());
        close.setSelected(config.isCloseSelected());
        volume.setSelected(config.isVolumeSelected());
        adjPrice.setSelected(config.isAdjPriceSelected());

        high.addItemListener(this);
        low.addItemListener(this);
        open.addItemListener(this);
        close.addItemListener(this);
        volume.addItemListener(this);
        adjPrice.addItemListener(this);
    }

    /**
     * 创建显示选中属性的表格
     *
     * @return 表格对象
     */
    private Table createSelectTable() {
        columnSelect = getSelectColumns();

        data = new Object[allData.length][];
        columns = new String[columnSelect.size()];

        for (int i = 0; i < columnSelect.size(); i++) {
            columns[i] = allColumns[columnSelect.get(i)];
        }
        for (int i = 0; i < data.length; i++) {
            data[i] = new Object[columnSelect.size()];
            for (int j = 0; j < columnSelect.size(); j++) {
                data[i][j] = allData[i][columnSelect.get(j)];
            }
        }

        return new Table(data, columns);
    }

    /**
     * 获得选中的列
     *
     * @return 列编号，日期必须显示
     */
    private List<Integer> getSelectColumns() {
        List<Integer> temp = new ArrayList<>();
        temp.add(0);
        if (high.isSelected()) {
            temp.add(1);
        }
        if (low.isSelected()) {
            temp.add(2);
        }
        if (open.isSelected()) {
            temp.add(3);
        }
        if (close.isSelected()) {
            temp.add(4);
        }
        if (volume.isSelected()) {
            temp.add(5);
        }
        if (adjPrice.isSelected()) {
            temp.add(6);
        }

        return temp;
    }

    /**
     * 固定时间间隔刷新面板
     */
    private void update() {
        new Thread() {
            @Override
            public void run() {
                try {
                    while (true) {
                        Thread.sleep(100);
                        repaint();
                    }
                } catch (Exception e) {
                }
            }
        }.start();
    }

    @Override
    public void itemStateChanged(ItemEvent e) {
        scrollPane.getViewport().remove(table);
        table = createSelectTable();
        scrollPane.getViewport().add(table);

        storeChange((JCheckBox) e.getSource());

        assignment();
    }

    /**
     * 存储变更
     *
     * @param item 变更的项目
     */
    private void storeChange(JCheckBox item) {
        if (item == high) {
            config.setHigh(high.isSelected());
        }
        if (item == low) {
            config.setLow(low.isSelected());
        }
        if (item == open) {
            config.setOpen(open.isSelected());
        }
        if (item == close) {
            config.setClose(close.isSelected());
        }
        if (item == volume) {
            config.setVolume(volume.isSelected());
        }
        if (item == adjPrice) {
            config.setAdjPrice(adjPrice.isSelected());
        }
    }
}
